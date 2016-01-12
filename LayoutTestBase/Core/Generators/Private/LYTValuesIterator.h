// © 2015 LinkedIn Corp. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at  http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class LYTDataValues;

@interface LYTValuesIterator : NSObject

@property (nonatomic, strong, nullable) LYTDataValues *dataValues;
@property (nonatomic) NSUInteger index;

@end

NS_ASSUME_NONNULL_END
