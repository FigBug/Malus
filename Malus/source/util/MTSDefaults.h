//
//  MTSDefaults.h
//
//  Created by Roland Rabien on 12-07-12.
//  Copyright (c) 2012 Roland Rabien. All rights reserved.
//
#import <Foundation/Foundation.h>

#define MTSDefaultsBoolForKey(key) [MTSDefaults boolForKey: key defaultValue: key##Default]
#define MTSDefaultsIntegerForKey(key) [MTSDefaults integerForKey: key defaultValue: key##Default]
#define MTSDefaultsStringArrayForKey(key) [MTSDefaults stringArrayForKey: key defaultValue: key##Default]
#define MTSDefaultsObjectForKey(key) [MTSDefaults objectForKey: key defaultValue: key##Default]
#define MTSDefaultsStringForKey(key) [MTSDefaults stringForKey: key defaultValue: key##Default]
#define MTSDefaultsDoubleForKey(key) [MTSDefaults doubleForKey: key defaultValue: key##Default]

#define MTSDefaultsSetBoolForKey(key, value) [MTSDefaults setBool: value forKey: key];
#define MTSDefaultsSetIntegerForKey(key, value) [MTSDefaults setInteger: value forKey: key];
#define MTSDefaultsSetStringArrayForKey(key, value) [MTSDefaults setObject: value forKey: key];
#define MTSDefaultsSetObjectForKey(key, value) [MTSDefaults setObject: value forKey: key];
#define MTSDefaultsSetStringForKey(key, value) [MTSDefaults setObject: value forKey: key];
#define MTSDefaultsSetDoubleForKey(key, value) [MTSDefaults setDouble: value forKey: key];

#define MTSDefaultsSetBoolToDefault(key) [MTSDefaults ifUnsetSetBool:key##Default forKey:key];
#define MTSDefaultsSetIntegerToDefault(key) [MTSDefaults ifUnsetSetInteger:key##Default forKey:key];
#define MTSDefaultsSetStringToDefault(key) [MTSDefaults ifUnsetSetObject:key##Default forKey:key];
#define MTSDefaultsSetObjectToDefault(key) [MTSDefaults ifUnsetSetObject:key##Default forKey:key];
#define MTSDefaultsSetStringArrayToDefault(key) [MTSDefaults ifUnsetSetObject:key##Default forKey:key];
#define MTSDefaultsSetDoubleToDefault(key) [MTSDefaults ifUnsetSetDouble:key##Default forKey:key];


@interface MTSDefaults : NSObject

+ (BOOL)boolForKey:(NSString*)key defaultValue:(BOOL)def;
+ (NSInteger)integerForKey:(NSString*)key defaultValue:(NSInteger)def;
+ (NSArray*)stringArrayForKey:(NSString*)key defaultValue:(NSArray*)def;
+ (id)objectForKey:(NSString*)key defaultValue:(id)def;
+ (NSString*)stringForKey:(NSString*)key defaultValue:(NSString*)def;
+ (double)doubleForKey:(NSString*)key defaultValue:(double)def;

+ (void)setBool:(BOOL)value forKey:(NSString*)defaultName;
+ (void)setInteger:(NSInteger)value forKey:(NSString*)defaultName;
+ (void)setObject:(NSObject*)value forKey:(NSString*)defaultName;
+ (void)setDouble:(double)value forKey:(NSString*)defaultName;

+ (void)ifUnsetSetBool:(BOOL)value forKey:(NSString*)key;
+ (void)ifUnsetSetInteger:(NSInteger)value forKey:(NSString*)key;
+ (void)ifUnsetSetObject:(NSObject*)value forKey:(NSString*)key;
+ (void)ifUnsetSetDouble:(double)value forKey:(NSString*)key;

+ (NSString*)namedDir:(NSString*)name;
+ (NSString*)settingsDir;
+ (NSString*)logDir;

@end
