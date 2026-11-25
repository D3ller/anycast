//
//  ResultSection.h
//  anycast
//
//  Created by Corentin on 25/11/2026.
//

#import <Cocoa/Cocoa.h>
#import "ResultEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultSection : NSObject
@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) NSArray<ResultEntry *>* entries;

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithTitle:(NSString*)title entries:(NSArray<ResultEntry *>*)entries;
@end

NS_ASSUME_NONNULL_END
