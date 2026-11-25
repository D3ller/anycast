//
//  CommandCatalog.m
//  anycast
//
//  Created by Corentin on 25/11/2026.
//

#import "CommandCatalog.h"
#import "Theme.h"
#import <IOBluetooth/IOBluetooth.h>
#import <dlfcn.h>

NS_ASSUME_NONNULL_BEGIN

extern int IOBluetoothPreferenceGetControllerPowerState(void);
extern void IOBluetoothPreferenceSetControllerPowerState(int state);

@implementation CommandCatalog

- (nonnull NSArray<ResultEntry *> *)systemCommands {
    ResultEntry *openBin = [[ResultEntry alloc] initWithName:NSLocalizedString(@"command.trash.name", nil) icon:[self iconWithSymbol:@"trash.fill"] kind:ResultKindCommand perform:^{
        NSURL *trash = [[NSFileManager defaultManager] URLForDirectory:NSTrashDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        if (trash) [[NSWorkspace sharedWorkspace] openURL:trash];
    }];
    
    ResultEntry *helpMe = [[ResultEntry alloc] initWithName:NSLocalizedString(@"command.support.name", nil) icon:[self iconWithSymbol:@"heart.fill"] kind:ResultKindCommand perform:^{
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://ko-fi.com/d3ller"]];
    }];
    
    ResultEntry *toggleBluetooth = [[ResultEntry alloc] initWithName:NSLocalizedString(@"command.bluetooth.name", nil) icon:[self iconWithSymbol:@"bluetooth"] kind:ResultKindCommand perform:^{
        int isOn = IOBluetoothPreferenceGetControllerPowerState();
        IOBluetoothPreferenceSetControllerPowerState(isOn ? 0 : 1);
    }];
    
    ResultEntry *toggleSound = [[ResultEntry alloc] initWithName:NSLocalizedString(@"command.sound.name", nil) icon:[self iconWithSymbol:@"speaker.fill"] kind:ResultKindCommand perform:^{
        NSDictionary *error = nil;
        NSAppleEventDescriptor *result = [[[NSAppleScript alloc] initWithSource:@"output muted of (get volume settings)"] executeAndReturnError:&error];
        if (error) {
            NSLog(@"Failed to read sound state: %@", error);
            return;
        }
        BOOL isMuted = result.booleanValue;

        NSString *toggle = isMuted ? @"set volume without output muted" : @"set volume with output muted";
        [[[NSAppleScript alloc] initWithSource:toggle] executeAndReturnError:&error];
        if (error) NSLog(@"Failed to toggle sound: %@", error);
    }];
    
    ResultEntry *toggleAppearance = [[ResultEntry alloc] initWithName:NSLocalizedString(@"command.appearance.name", nil) icon:[self iconWithSymbol:@"circle.lefthalf.filled"] kind:ResultKindCommand perform:^{
        NSString *source = @"tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode";
        NSDictionary *error = nil;
        [[[NSAppleScript alloc] initWithSource:source] executeAndReturnError:&error];
        if (error) NSLog(@"Failed to toggle appearance: %@", error);
    }];

    ResultEntry *turnOff = [[ResultEntry alloc] initWithName:NSLocalizedString(@"command.poweroff.name", nil) icon:[self iconWithSymbol:@"power.dotted"] kind:ResultKindCommand perform:^{}];

    ResultEntry *lockScreen = [[ResultEntry alloc] initWithName:NSLocalizedString(@"command.lock.name", nil) icon:[self iconWithSymbol:@"lock.fill"] kind:ResultKindCommand perform:^{
        void *login = dlopen("/System/Library/PrivateFrameworks/login.framework/Versions/Current/login", RTLD_LAZY);
        void (*lock)(void) = login ? dlsym(login, "SACLockScreenImmediate") : NULL;
        if (lock) {
            lock();
            return;
        }
        NSTask *task = [[NSTask alloc] init];
        task.executableURL = [NSURL fileURLWithPath:@"/usr/bin/pmset"];
        task.arguments = @[@"displaysleepnow"];
        [task launchAndReturnError:nil];
    }];

    ResultEntry *toggleStageManager = [[ResultEntry alloc] initWithName:NSLocalizedString(@"command.stagemanager.name", nil) icon:[self iconWithSymbol:@"squares.leading.rectangle.fill"] kind:ResultKindCommand perform:^{
        NSUserDefaults *windowManager = [[NSUserDefaults alloc] initWithSuiteName:@"com.apple.WindowManager"];
        BOOL isOn = [windowManager boolForKey:@"GloballyEnabled"];
        [windowManager setBool:!isOn forKey:@"GloballyEnabled"];
        [windowManager synchronize];
    }];

    ResultEntry *volumeMute = [self volumeCommandWithName:NSLocalizedString(@"command.volume0.name", nil) symbol:@"speaker.fill" level:0];
    ResultEntry *volumeHalf = [self volumeCommandWithName:NSLocalizedString(@"command.volume50.name", nil) symbol:@"speaker.wave.1.fill" level:50];
    ResultEntry *volumeMax = [self volumeCommandWithName:NSLocalizedString(@"command.volume100.name", nil) symbol:@"speaker.wave.2.fill" level:100];

    return @[lockScreen, toggleStageManager, toggleBluetooth, toggleSound, toggleAppearance, volumeMute, volumeHalf, volumeMax, openBin, helpMe, turnOff];
}

- (ResultEntry *)volumeCommandWithName:(NSString *)name symbol:(NSString *)symbol level:(NSInteger)level {
    return [[ResultEntry alloc] initWithName:name icon:[self iconWithSymbol:symbol] kind:ResultKindCommand perform:^{
        NSString *source = [NSString stringWithFormat:@"set volume output volume %ld", (long)level];
        NSDictionary *error = nil;
        [[[NSAppleScript alloc] initWithSource:source] executeAndReturnError:&error];
        if (error) NSLog(@"Failed to set volume: %@", error);
    }];
}

- (NSImage *)generateIconImage:(NSString *)iconName {
    NSImage *symbol = [NSImage imageWithSystemSymbolName:iconName accessibilityDescription:nil];
    if (!symbol) symbol = [NSImage imageNamed:iconName];

    NSImageSymbolConfiguration *config = [NSImageSymbolConfiguration configurationWithPointSize:18 weight:NSFontWeightRegular];
    NSImageSymbolConfiguration *color = [NSImageSymbolConfiguration configurationWithHierarchicalColor:[NSColor colorWithWhite:1 alpha:0.85]];
    config = [config configurationByApplyingConfiguration:color];

    return [symbol imageWithSymbolConfiguration:config];
}

- (NSImage *)iconWithSymbol:(NSString *)name {
    NSImage *symbol = [self generateIconImage:name];
    NSSize size = NSMakeSize(iconSize + 6, iconSize + 6);

    return [NSImage imageWithSize:size flipped:NO drawingHandler:^BOOL(NSRect rect) {
        NSBezierPath *tile = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:7 yRadius:7];
        [[NSColor colorWithWhite:1 alpha:0.12] setFill];
        [tile fill];

        NSSize s = symbol.size;
        [symbol drawInRect:NSMakeRect((rect.size.width - s.width) / 2,
                                      (rect.size.height - s.height) / 2,
                                      s.width, s.height)];
        return YES;
    }];
}

@end

NS_ASSUME_NONNULL_END
