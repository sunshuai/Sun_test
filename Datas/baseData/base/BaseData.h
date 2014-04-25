//
//  BaseData.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GDataXMLNode.h"
#import "JSON.h"
#import "SQLitePersistentObject.h"

#define DECLARE_STRUCTS(sd) + (NSDictionary *)getStructsList \
{ \
return (NSDictionary*)[sd JSONValue]; \
}

@interface BaseData : SQLitePersistentObject {
    
}

/**
 返回该类的结构
 */
+(NSDictionary*)getStructsList;

/**
 根据XmlElement中的XmlNode填充相应的属性值。
 xmlNode的name对应该类中的mname属性, 例如: xmlNode的name为address, 则对应本类的属性为maddress。
 @param xmlElement Xml数据
 @returns 已填充了属性值的YK_BaseData实例化对象
 */
-(BaseData*)parseFromGDataXMLElement:(GDataXMLElement*)xmlElement;

/**
 根据XmlElement中的StringValue填充相应的属性值。
 XmlElement的name对应该类中的mname属性, 例如: XmlElement的name为address, 则对应本类的属性为maddress。
 @param xmlElement Xml数据
 @returns 已填充了属性值的YK_BaseData实例化对象
 */
-(BaseData*)parseStringValueFromGDataXmlElement:(GDataXMLElement*)xmlElement;
/**
 解析属性和单结点。
 XmlElement的name对应该类中的mname属性, 例如: XmlElement的name为address, 则对应本类的属性为maddress。
 @param xmlElement Xml数据
 @returns 已填充了属性值的YK_BaseData实例化对象
 */
-(BaseData*)parseAttriAndNodeFromXmlElement:(GDataXMLElement*)xmlElement;
/**
 根据dict中的key填充相应的属性值。
 key 对应本类中的mkey属性, 例如: key为address, 则对应本类的属性为maddress。
 @param dict 数据字典
 @returns 已填充了属性值的YK_BaseData实例化对象
 */
-(BaseData*)parseFromDictionary:(NSDictionary*)dict;

/**
 {
 Class: Class
 NodePath: "//nodepath"
 CDATAName: "mdatavalue"
 CDATAValue: "mdataname"
 数组字段: 数组成员类名
 }
 嵌套解析方法。根据配置信息自动完成属性及嵌套解析。
 @param xmlElement Xml数据
 @returns 已填充了属性值的YK_BaseData实例化对象
 */
+(NSArray*)easyParseFromGDataXMLElement:(GDataXMLElement*)xmlElement;


@end
