/* Copyright (c) 2007 Google Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

//
//  GDataGeoPt.m
//
//  NOTE: As of July 2007, GDataGeoPt is deprecated.  Use GDataGeo instead.
//

#import "GDataGeoPt.h"
#import "GDataDateTime.h"

@implementation GDataGeoPt
// geoPt element, as in
//   <gd:geoPt lat="27.98778" lon="86.94444" elev="8850.0"/>
//
// http://code.google.com/apis/gdata/common-elements.html#gdGeoPt

+ (NSString *)extensionElementURI       { return kGDataNamespaceGData; }
+ (NSString *)extensionElementPrefix    { return kGDataNamespaceGDataPrefix; }
+ (NSString *)extensionElementLocalName { return @"geoPt"; }

- (GDataGeoPt *)geoPtWithLabel:(NSString *)label
                           lat:(NSNumber *)lat
                           lon:(NSNumber *)lon
                          elev:(NSNumber *)elev
                          time:(GDataDateTime *)time {
  GDataGeoPt *obj = [[[GDataGeoPt alloc] init] autorelease];
  [obj setLabel:label];
  [obj setLat:lat];
  [obj setLon:lon];
  [obj setElev:elev];
  [obj setTime:time];
  return obj;
}

- (id)initWithXMLElement:(NSXMLElement *)element
                  parent:(GDataObject *)parent {
  self = [super initWithXMLElement:element
                            parent:parent];
  if (self) {
    [self setLabel:[self stringForAttributeName:@"label" 
                                    fromElement:element]];
    [self setLat:[self doubleNumberForAttributeName:@"lat" 
                                        fromElement:element]];
    [self setLon:[self doubleNumberForAttributeName:@"lon" 
                                        fromElement:element]];
    [self setElev:[self doubleNumberForAttributeName:@"elev" 
                                         fromElement:element]];
    [self setTime:[self dateTimeForAttributeName:@"time" 
                                     fromElement:element]];
  }
  return self;
}

- (void)dealloc {
  [label_ release];
  [lat_ release];
  [lon_ release];
  [elev_ release];
  [time_ release];
  [super dealloc];
}

- (id)copyWithZone:(NSZone *)zone {
  GDataGeoPt* newObj = [super copyWithZone:zone];
  [newObj setLabel:label_];
  [newObj setLat:lat_];
  [newObj setLon:lon_];
  [newObj setElev:elev_];
  [newObj setTime:time_];
  return newObj;
}

- (BOOL)isEqual:(GDataGeoPt *)other {
  if (self == other) return YES;
  if (![other isKindOfClass:[GDataGeoPt class]]) return NO;
  
  // the stringValue of an NSNumber is a rounded version; compare those
  // rather than non-rounded versions
  return [super isEqual:other]
    && AreEqualOrBothNil([self label], [other label])
    && AreEqualOrBothNil([[self lat] stringValue], [[other lat] stringValue])
    && AreEqualOrBothNil([[self lon] stringValue], [[other lon] stringValue])
    && AreEqualOrBothNil([[self elev] stringValue], [[other elev] stringValue])
    && AreEqualOrBothNil([self time], [other time]);
}

- (NSString *)description {
  NSMutableArray *items = [NSMutableArray array];
  
  [self addToArray:items objectDescriptionIfNonNil:label_ withName:@"label"];
  [self addToArray:items objectDescriptionIfNonNil:lat_ withName:@"lat"];
  [self addToArray:items objectDescriptionIfNonNil:lon_ withName:@"lon"];
  [self addToArray:items objectDescriptionIfNonNil:elev_ withName:@"elev"];
  [self addToArray:items objectDescriptionIfNonNil:time_ withName:@"time"];
  
  return [NSString stringWithFormat:@"%@ 0x%lX: {%@}",
    [self class], self, [items componentsJoinedByString:@" "]];
}

- (NSXMLElement *)XMLElement {

  NSXMLElement *element = [self XMLElementWithExtensionsAndDefaultName:@"gd:geoPt"];
  
  [self addToElement:element attributeValueIfNonNil:[self label] withName:@"label"];
  [self addToElement:element attributeValueIfNonNil:[[self lat] stringValue] withName:@"lat"];
  [self addToElement:element attributeValueIfNonNil:[[self lon] stringValue] withName:@"lon"];
  [self addToElement:element attributeValueIfNonNil:[[self elev] stringValue] withName:@"elev"];
  [self addToElement:element attributeValueIfNonNil:[[self time] RFC3339String] withName:@"time"];
  
  return element;
}

- (NSString *)label {
  return label_; 
}

- (void)setLabel:(NSString *)str {
  [label_ autorelease];
  label_ = [str copy];
}

- (NSNumber *)lat {
  return lat_; 
}

- (void)setLat:(NSNumber *)num {
  [lat_ autorelease];
  lat_ = [num copy];
}

- (NSNumber *)lon {
  return lon_; 
}

- (void)setLon:(NSNumber *)num {
  [lon_ autorelease];
  lon_ = [num copy];
}

- (NSNumber *)elev {
  return elev_; 
}

- (void)setElev:(NSNumber *)num {
  [elev_ autorelease];
  elev_ = [num copy];
}

- (GDataDateTime *)time {
  return time_;
}

- (void)setTime:(GDataDateTime *)cdate {
  [time_ autorelease];
  time_ = [cdate retain];
}

@end


