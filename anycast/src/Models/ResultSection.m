//
//  ResultSection.m
//  anycast
//
//  Created by Corentin on 25/11/2026.
//

#import "ResultSection.h"

@implementation ResultSection

- (instancetype)initWithTitle:(NSString *)title entries:(NSArray<ResultEntry *> *)entries {
    self = [super init];
    if(self) {
        _title = [title copy];
        _entries = entries;
    }
    return self;
}

@end
