//
//  ResultEntry.h
//  anycast
//
//  Created by Corentin on 24/11/2026.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ResultKind) {
    ResultKindApplication,
    ResultKindCommand,
    ResultKindExtension
};

@interface ResultEntry : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong, nullable) NSImage* icon;
@property (nonatomic) ResultKind kind;
@property (nonatomic, copy, nonnull) void (^perform)(void);

- (instancetype)initWithName:(NSString *)name
                        icon:(nullable NSImage *)icon
                        kind:(ResultKind)kind
                     perform:(void (^)(void))perform;
- (instancetype)init NS_UNAVAILABLE;

- (NSString *)kindLabel;
- (NSString *)primaryActionTitle;

@end

NS_ASSUME_NONNULL_END
