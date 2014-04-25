//
//  DataInterface.h
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//


#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)



#pragma mark - 接口

/*
 服务器接口路径
 */
extern const NSString *YK_SERVER_PATH;//正式或测试服务器地址
extern const NSString* YK_URL_GET_SERVER_TIME;              // 获取服务器时间
extern const NSString* YK_URL_POST_CLIENT_INFO;            // 上传客户端信息
extern const NSString* YK_URL_POST_ODER_INFO;            // 上传订单信息

/*
 接口URL
 */
// 启动加载
extern const NSString *YK_URL_CHECK_VERSION;//版本检测
extern const NSString *YK_URL_LOADING_IMG;//Loading图片
extern const NSString *YK_URL_DEVICETOKEN;//提交DeviceToken
extern const NSString *YK_URL_SERVER_TIME;//获取服务器时间
// 用户相关
extern const NSString *YK_URL_LOGIN;//用户登录
extern const NSString *YK_URL_LOGOUT;//用户登出
extern const NSString *YK_URL_REGISTER;//用户注册
extern const NSString *YK_URL_UNIONLOGIN;//联合登录
// 首页相关
extern const NSString *YK_URL_HOME_INDEX;//首页活动
// 分类相关
extern const NSString *YK_URL_CLASSIFY_LIST;//分类列表
// 商品相关
extern const NSString *YK_URL_PRODUCT_LIST;//商品列表
extern const NSString *YK_URL_PRODUCT_FILTER;//商品筛选条件
extern const NSString *YK_URL_PRODUCT_DETAIL;//商品详情
extern const NSString *YK_URL_PRODUCT_DESCRIPTION;//产品细节描述
extern const NSString *YK_URL_PRODUCT_COMMENT_LIST;//用户体验
extern const NSString *YK_URL_PRODUCT_QA_LIST;//Q&A
extern const NSString *YK_URL_PRODUCT_QUESTION;//用户提问
extern const NSString *YK_URL_PRODUCT_STOCK;//库存状态
// 购物袋相关
extern const NSString *YK_URL_SHOPPINGBAG_INFO;//购物车信息
extern const NSString *YK_URL_SHOPPINGBAG_COUPON_LIST;//查看可用优惠券列表
// 结算相关
extern const NSString *YK_URL_CHECKOUT_SAVE_INVOICE;//保存发票信息
extern const NSString *YK_URL_CHECKOUT_INFO;     //查看购物车信息
extern const NSString *YK_URL_CHECKOUT_ORDER_SUBMIT;//提交订单

// 我的魅力惠
extern const NSString *YK_URL_ACCOUNT_INFO;//我的魅力惠首页信息
extern const NSString *YK_URL_ACCOUNT_MEMBER_INFO;//个人信息
extern const NSString *YK_URL_ACCOUNT_MEMBER_INFO_UPDATE;//修改个人信息
extern const NSString *YK_URL_ACCOUNT_MAIL_LIST;//站内信列表
extern const NSString *YK_URL_ACCOUNT_MAIL_DETAIL;//查看站内信详情
extern const NSString *YK_URL_ACCOUNT_MAIL_DELETE;//删除站内信
extern const NSString *YK_URL_ACCOUNT_ORDER_LIST;//订单列表
extern const NSString *YK_URL_ACCOUNT_ORDER_DETAIL;//查看订单详情
extern const NSString *YK_URL_ACCOUNT_ORDER_CANCEL;//取消订单
extern const NSString *YK_URL_ACCOUNT_COMMENT_PRODUCT_LIST;//待评论商品列表
extern const NSString *YK_URL_ACCOUNT_COMMENT_SUBMIT;//评论提交
extern const NSString *YK_URL_ACCOUNT_COMMENT_LIST;//我的评论
extern const NSString *YK_URL_ACCOUNT_BALANCE;//账户余额
extern const NSString *YK_URL_ACCOUNT_COUPON_LIST;//优惠券列表
// 地址相关
extern const NSString *YK_URL_ADDRESS_LIST;//地址列表
extern const NSString *YK_URL_ADDRESS_ADD;//地址增加
extern const NSString *YK_URL_ADDRESS_DELETE;//地址删除
extern const NSString *YK_URL_ADDRESS_UPDATE;//地址更新
extern const NSString *YK_URL_ADDRESS_DEFAULT;//默认地址
// 更多
extern const NSString *YK_URL_PUSH_RECEIVE;//是否接收推送
extern const NSString *YK_URL_SUBMIT_FEEDBACK;//提交反馈
extern const NSString *YK_URL_HELP_LIST;//帮助信息列表
// 支付宝
extern const NSString *YK_URL_ALIPAY_INFO;//支付宝交易信息
extern const NSString *YK_URL_ALIPAY_WAP_INFO;//支付宝wap交易信息

#pragma mark - 字段
/*
 公用字段
 */
extern const NSString *YK_KEY_SOURCE_ID;  //推广ID
extern const NSString *YK_VALUE_SOURCE_ID;//推广ID
extern const NSString *YK_KEY_SCREENSIZE;//屏幕尺寸
extern const NSString *YK_VALUE_SCREENSIZE;//屏幕尺寸
extern const NSString *YK_KEY_PLATFORM;//平台
extern const NSString *YK_VALUE_PLATFORM;//平台
extern const NSString *YK_KEY_UDID;//设备唯一标识符
extern const NSString *YK_VALUE_UDID;//设备唯一标识符
extern const NSString *YK_KEY_CLIENT_VER;//客户端版本号
extern const NSString *YK_VALUE_CLIENT_VER;//客户端版本号
extern const NSString *YK_KEY_PROTOCOL_VER;//通讯协议版本号
extern const NSString *YK_VALUE_PROTOCOL_VER;//通讯协议版本号
extern const NSString *YK_KEY_SUBSOURCE_ID;//子推广ID
extern const NSString *YK_VALUE_SUBSOURCE_ID;//子推广ID
extern const NSString *YK_KEY_MODEL;//手机型号
extern const NSString *YK_VALUE_MODEL;//手机型号
extern const NSString *YK_KEY_CARRIER;//运营商
extern const NSString *YK_VALUE_CARRIER;//运营商
extern const NSString *YK_KEY_TIMESTAMP;//客户端时间戳
extern const NSString *YK_VALUE_TIMESTAMP;//客户端时间戳
extern const NSString *YK_KEY_SIGN;//签名字符串
extern const NSString *YK_VALUE_SIGN;//签名字符串

extern const NSString *YK_VALUE_DeviceToken;//DeviceToken

/*
 请求字段
 */
extern const NSString *YK_KEY_PAGE_INDEX;           //页码
extern const NSString *YK_KEY_PAGE_SIZE;            //页面大小
extern const NSString *YK_KEY_HOME_TYPE;            //首页活动类型
extern const NSString *YK_KEY_NETWORK_TYPE;         //网络类型
extern const NSString *YK_KEY_CATEGORY_ID;          //分类ID
extern const NSString *YK_KEY_FILTER_STR;           //筛选条件字符串
extern const NSString *YK_KEY_PRODUCT_ID;           //商品ID
extern const NSString *YK_KEY_USER_ID;              //用户ID
extern const NSString *YK_KEY_USER_TOKEN;           //用户登录令牌
extern const NSString *YK_KEY_PRODUCT_QUESTION;     //用户提问
extern const NSString *YK_KEY_DEVICETOKEN;          //DeviceToken
extern const NSString *YK_KEY_MAIL_ID;              //站内信ID
extern const NSString *YK_KEY_ORDER_NO;             //订单号
extern const NSString *YK_KEY_COMMENT;              //评论内容
extern const NSString *YK_KEY_ADDRESS_ID;           //地址ID
extern const NSString *YK_KEY_ADDRESS_NAME;         //收件人姓名
extern const NSString *YK_KEY_ADDRESS_MOBILE;       //手机
extern const NSString *YK_KEY_ADDRESS_PHONE;        //电话
extern const NSString *YK_KEY_ADDRESS_PROVINCE_ID;  //省ID
extern const NSString *YK_KEY_ADDRESS_PROVINCE;     //省
extern const NSString *YK_KEY_ADDRESS_CITY;         //市
extern const NSString *YK_KEY_ADDRESS_DISTRICT;     //区
extern const NSString *YK_KEY_ADDRESS_STREET;       //街道
extern const NSString *YK_KEY_ADDRESS_POSTCODE;     //邮编
extern const NSString *YK_KEY_PUSH_RECEIVE;         //是否接受推送
extern const NSString *YK_KEY_FEEDBACK;             //反馈信息
extern const NSString *YK_KEY_SKUSTR;               //购物车商品的sku拼接字符串
extern const NSString *YK_KEY_COUPON_CODE;          //优惠券号码
extern const NSString *YK_KEY_DELIVERY_TIME;        //送货时间
extern const NSString *YK_KEY_SHIPPING_METHOD;      //送货方式
extern const NSString *YK_KEY_HAS_INVOICE;          //是否开发票
extern const NSString *YK_KEY_INVOICEHEADER;        //发票抬头
extern const NSString *YK_KEY_IS_USEBALANCE;        //是否使用余额支付
extern const NSString *YK_KEY_PAYMENT_METHOD;       //支付方式




#import <Foundation/Foundation.h>

@interface DataInterface : NSObject
{
}

//初始化
+ (void)initialize;

//设置字典的键值
+ (void)setCommonParam:(id)key value:(id)value;

//根据键返回字典的值
+ (id)commonParam:(id) key;

//返回字典
+ (NSMutableDictionary *)commonParams;
//遍历字典并输出键值
+ (void)walkDataInterface;

//返回额外的头信息
+ (NSDictionary*)extraHeaders;

//返回sourceId
+ (NSString*)sourceid;

//运营商信息
+(NSString *)getCarrierName;



@end
