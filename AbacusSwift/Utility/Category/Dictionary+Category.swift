//
//  Dictionary+Category.swift
//  AbacusSwift
//
//  Created by WilliamZhang on 16/1/11.
//  Copyright © 2016年 William Zhang. All rights reserved.
//

import Foundation

//private extension Dictionary {
//    func safeValueForKeyPath(keyPath: String) -> AnyObject {
//        
//    }
//    
//    func safeValueForKeyPath(keyPath: String, aClass: AnyClass) -> AnyObject {
//        var value = [keyPath]
//        
//    }
//}
//
//- (id)safeValueForKey:(NSString *)key {
//    return [self safeValueForKey:key originalClass:nil];
//    }
//    
//    - (id)safeValueForKey:(NSString *)key originalClass:(Class)aClass {
//        return [self safeValueForKeyPath:key originalClass:aClass];
//        }
//        
//        - (id)safeValueForKeyPath:(NSString *)keyPath {
//            return [self safeValueForKeyPath:keyPath originalClass:nil];
//            }
//            
//            - (id)safeValueForKeyPath:(NSString *)keyPath originalClass:(Class)aClass {
//                id value = [self valueForKeyPath:keyPath];
//                if ([value isKindOfClass:[NSNull class]]) {
//                    value = nil;
//                }
//                
//                if (value) {
//                    return value;
//                }
//                
//                if (aClass == [NSString class]) {
//                    return @"";
//                }
//                
//                if (aClass == [NSNumber class]) {
//                    return @0;
//                }
//                
//                NSArray *array = @[@"NSArray",
//                @"NSMutaleArray",
//                @"NSDictionary",
//                @"NSMutableDictionary",
//                @"NSDate"];
//                
//                for (NSString *className in array) {
//                    Class bClass = NSClassFromString(className);
//                    if (aClass != bClass) {
//                        continue;
//                    }
//                    
//                    value = [[bClass alloc] init];
//                    break;
//                }
//                
//                return value;
//}
