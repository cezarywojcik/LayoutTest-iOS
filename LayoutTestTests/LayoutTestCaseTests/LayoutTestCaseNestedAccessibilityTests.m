// © 2015 LinkedIn Corp. All rights reserved.
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at  http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

#import "LayoutTest.h"
#import "LayoutTestBase.h"
#import "UnitTestViews.h"


@interface LayoutTestCaseNestedAccessibilityTests : LYTLayoutTestCase <LYTViewProvider>

@property (nonatomic) NSInteger testFailures;

@end

@implementation LayoutTestCaseNestedAccessibilityTests

- (void)testFails {
    __block NSInteger timesCalled = 0;
    [self runLayoutTestsWithViewProvider:[self class] validation:^(UIView * view, NSDictionary * data, id context) {
        timesCalled++;
    }];

    XCTAssertEqual(timesCalled, 2);
    XCTAssertEqual(self.testFailures, 1);
}

- (void)testNoFailWithAllowErrors {
    __block NSInteger timesCalled = 0;
    [self runLayoutTestsWithViewProvider:[self class] validation:^(UIView *view, NSDictionary * data, id context) {
        timesCalled++;

        [self.viewsAllowingAccessibilityErrors addObject:view.subviews[0]];
    }];

    XCTAssertEqual(timesCalled, 2);
    XCTAssertEqual(self.testFailures, 0);

    self.interceptsAutolayoutErrors = YES;
}

- (void)testNoFailWithAccessibilityOff {
    self.accessibilityTestsEnabled = NO;

    __block NSInteger timesCalled = 0;
    [self runLayoutTestsWithViewProvider:[self class] validation:^(UIView * view, NSDictionary * data, id context) {
        timesCalled++;
    }];

    XCTAssertEqual(timesCalled, 2);
    XCTAssertEqual(self.testFailures, 0);

    self.accessibilityTestsEnabled = YES;
}

#pragma mark - Override

- (void)failTest:(NSString *)errorMessage view:(UIView *)view {
    self.testFailures++;
}

#pragma mark - LYTViewProvider

+ (NSDictionary *)dataSpecForTest {
    // Return 3 views to test. One correct view, on view with overlapping subviews and one view with a switch subview.
    return @{
             @"view": [[LYTDataValues alloc] initWithValues:@[
                                                                  [UnitTestViews viewWithNoProblems],
                                                                  [UnitTestViews viewWithNestedAccessibility]
                                                                  ]]
             };
}

+ (UIView *)viewForData:(NSDictionary *)data reuseView:(UIView *)view size:(LYTViewSize *)size context:(id *)context {
    return data[@"view"];
}

@end
