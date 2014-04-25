//
//  DataInterface.m
//  Sun_test
//
//  Created by Shuai Sun on 12-8-3.
//  Copyright (c) 2012年 Yek.me. All rights reserved.
//

#import "UIDevice+IdentifierAddition.h"
/**
 服务器接口路径
 */
#ifdef TEST_URL
const NSString *YK_SERVER_PATH = @"http://uji.glamour-sales.com.cn/mobile";
//const NSString *YK_SERVER_PATH = @"http://v2.glamour-sales.com.cn/mobile";
const NSString* YK_URL_GET_SERVER_TIME              = @"http://mobapi.250y.com/test/time.php";              // 获取服务器时间
const NSString* YK_URL_POST_CLIENT_INFO             = @"http://mobapi.250y.com/test/client.php";            // 上传客户端信息
const NSString* YK_URL_POST_ODER_INFO               = @"http://mobapi.250y.com/test/order.php";            // 上传订单信息
#else
const NSString *YK_SERVER_PATH = @"http://www.glamour-sales.com.cn/mobile";
const NSString* YK_URL_GET_SERVER_TIME = @"http://mobapi.250y.com/time.php";              // 获取服务器时间
const NSString* YK_URL_POST_CLIENT_INFO = @"http://mobapi.250y.com/client.php";            // 上传客户端信息
const NSString* YK_URL_POST_ODER_INFO = @"http://mobapi.250y.com/order.php";             // 上传订单信息
#endif
/*
 接口URL
 */
// 启动加载
const NSString *YK_URL_CHECK_VERSION = @"/index/version";//版本检测
const NSString *YK_URL_LOADING_IMG = @"/index/loading";//Loading图片
const NSString *YK_URL_DEVICETOKEN = @"/index/device";//提交DeviceToken
const NSString *YK_URL_SERVER_TIME = @"/index/serverTime";//获取服务器时间
// 用户相关
const NSString *YK_URL_LOGIN = @"/customer/login";//用户登录
const NSString *YK_URL_LOGOUT = @"/customer/logout";//用户登出
const NSString *YK_URL_REGISTER = @"/customer/register";//用户注册
const NSString *YK_URL_UNIONLOGIN = @"/customer/loginByThirdparty";//联合登录
// 首页相关
const NSString *YK_URL_HOME_INDEX = @"/home/index";//首页活动
// 分类相关
const NSString *YK_URL_CLASSIFY_LIST = @"/category/list";//分类列表
// 商品相关
const NSString *YK_URL_PRODUCT_LIST = @"/product/list";//商品列表
const NSString *YK_URL_PRODUCT_FILTER = @"/product/filter";//商品筛选条件
const NSString *YK_URL_PRODUCT_DETAIL = @"/product/detail";//商品详情
const NSString *YK_URL_PRODUCT_DESCRIPTION = @"/product/description";//产品细节描述
const NSString *YK_URL_PRODUCT_COMMENT_LIST = @"/product/review";//用户体验
const NSString *YK_URL_PRODUCT_QA_LIST = @"/product/qa";//Q&A
const NSString *YK_URL_PRODUCT_QUESTION = @"/product/question";//用户提问
const NSString *YK_URL_PRODUCT_STOCK = @"/product/stock";//库存状态
// 购物袋相关
const NSString *YK_URL_SHOPPINGBAG_INFO = @"/cart/view";//购物车信息
const NSString *YK_URL_SHOPPINGBAG_COUPON_LIST = @"/checkout/coupon";//查看可用优惠券列表
// 结算相关
const NSString *YK_URL_CHECKOUT_SAVE_INVOICE = @"/checkout/saveInvoiceAddress";//保存发票信息
const NSString *YK_URL_CHECKOUT_INFO = @"/checkout/info";     //查看结算中心信息
const NSString *YK_URL_CHECKOUT_ORDER_SUBMIT = @"/checkout/submitOrder";//提交订单
// 我的魅力惠
const NSString *YK_URL_ACCOUNT_INFO = @"/myaccount/index";//我的魅力惠首页信息
const NSString *YK_URL_ACCOUNT_MEMBER_INFO = @"/myaccount/info";//个人信息
const NSString *YK_URL_ACCOUNT_MEMBER_INFO_UPDATE = @"/myaccount/update";//修改个人信息
const NSString *YK_URL_ACCOUNT_MAIL_LIST = @"/myaccount/mailList";//站内信列表
const NSString *YK_URL_ACCOUNT_MAIL_DETAIL = @"/myaccount/mailDetail";//查看站内信详情
const NSString *YK_URL_ACCOUNT_MAIL_DELETE = @"/myaccount/mailDelete";//删除站内信
const NSString *YK_URL_ACCOUNT_ORDER_LIST = @"/myaccount/orderList";//订单列表
const NSString *YK_URL_ACCOUNT_ORDER_DETAIL = @"/myaccount/orderDetail";//查看订单详情
const NSString *YK_URL_ACCOUNT_ORDER_CANCEL = @"/myaccount/orderCancel";//取消订单
const NSString *YK_URL_ACCOUNT_COMMENT_PRODUCT_LIST = @"/myaccount/waitComment";//待评论商品列表
const NSString *YK_URL_ACCOUNT_COMMENT_SUBMIT = @"/myaccount/addComment";//评论提交
const NSString *YK_URL_ACCOUNT_COMMENT_LIST = @"/myaccount/commentList";//我的评论
const NSString *YK_URL_ACCOUNT_BALANCE = @"/myaccount/balance";//账户余额
const NSString *YK_URL_ACCOUNT_COUPON_LIST = @"/myaccount/coupon";//优惠券列表
// 地址相关
const NSString *YK_URL_ADDRESS_LIST = @"/myaccount/addressList";//地址列表
const NSString *YK_URL_ADDRESS_ADD = @"/myaccount/addAddress";//地址增加
const NSString *YK_URL_ADDRESS_DELETE = @"/myaccount/deleteAddress";//地址删除
const NSString *YK_URL_ADDRESS_UPDATE = @"/myaccount/updateAddress";//地址更新
const NSString *YK_URL_ADDRESS_DEFAULT = @"/myaccount/defaultAddress";//默认地址
// 更多
const NSString *YK_URL_PUSH_RECEIVE = @"/more/push";//是否接收推送
const NSString *YK_URL_SUBMIT_FEEDBACK = @"/more/feedback";//提交反馈
const NSString *YK_URL_HELP_LIST = @"/more/help";//帮助信息列表

// 支付宝
const NSString *YK_URL_ALIPAY_INFO = @"/payment/info";//支付宝交易信息
const NSString *YK_URL_ALIPAY_WAP_INFO = @"/payment/wap";//支付宝wap交易信息

/*
 公用字段
 */
const NSString *YK_KEY_SOURCE_ID = @"sourceId";
const NSString *YK_VALUE_SOURCE_ID = @"sourceIDValue";
const NSString *YK_KEY_SCREENSIZE = @"screenSize";
const NSString *YK_VALUE_SCREENSIZE = @"";
const NSString *YK_KEY_PLATFORM = @"platform";
const NSString *YK_VALUE_PLATFORM = @"iphone";
const NSString *YK_KEY_UDID = @"udid";
const NSString *YK_VALUE_UDID = @"";
const NSString *YK_KEY_CLIENT_VER = @"clientVer";
const NSString *YK_VALUE_CLIENT_VER = @"1.0.0";
const NSString *YK_KEY_PROTOCOL_VER = @"protocolVer";
const NSString *YK_VALUE_PROTOCOL_VER = @"1.0.0";
const NSString *YK_KEY_SUBSOURCE_ID = @"subSourceId";
const NSString *YK_VALUE_SUBSOURCE_ID = @"subSourceIdValue";
const NSString *YK_KEY_MODEL = @"model";
const NSString *YK_VALUE_MODEL = @"";
const NSString *YK_KEY_CARRIER = @"carrier"; 
const NSString *YK_VALUE_CARRIER = @"";
const NSString *YK_KEY_TIMESTAMP = @"timeStamp";
const NSString *YK_VALUE_TIMESTAMP = @"";
const NSString *YK_KEY_SIGN = @"sign";
const NSString *YK_VALUE_SIGN = @"";
const NSString *YK_VALUE_DeviceToken = @"";
/*
 请求字段
 */
const NSString *YK_KEY_PAGE_INDEX = @"pageIndex";       //页码
const NSString *YK_KEY_PAGE_SIZE = @"pageSize";         //页面大小
const NSString *YK_KEY_HOME_TYPE = @"type";             //首页活动类型
const NSString *YK_KEY_NETWORK_TYPE = @"networkType";   //网络类型
const NSString *YK_KEY_CATEGORY_ID = @"categoryId";     //分类ID
const NSString *YK_KEY_FILTER_STR = @"filter";          //筛选条件字符串
const NSString *YK_KEY_PRODUCT_ID = @"productId";       //商品ID
const NSString *YK_KEY_USER_ID = @"userId";             //用户ID
const NSString *YK_KEY_USER_TOKEN = @"userToken";       //用户登录令牌
const NSString *YK_KEY_PRODUCT_QUESTION = @"question";  //用户提问
const NSString *YK_KEY_DEVICETOKEN = @"deviceToken";    //DeviceToken
const NSString *YK_KEY_MAIL_ID = @"mailId";             //站内信ID
const NSString *YK_KEY_ORDER_NO = @"orderNo";           //订单号
const NSString *YK_KEY_COMMENT = @"comment";            //评论内容
const NSString *YK_KEY_ADDRESS_ID = @"addressId";           //地址ID
const NSString *YK_KEY_ADDRESS_NAME = @"name";              //收件人姓名
const NSString *YK_KEY_ADDRESS_MOBILE = @"mobile";          //手机
const NSString *YK_KEY_ADDRESS_PHONE = @"phone";            //电话
const NSString *YK_KEY_ADDRESS_PROVINCE_ID = @"provinceId"; //省ID
const NSString *YK_KEY_ADDRESS_PROVINCE = @"province";      //省
const NSString *YK_KEY_ADDRESS_CITY = @"city";              //市
const NSString *YK_KEY_ADDRESS_DISTRICT = @"district";      //区
const NSString *YK_KEY_ADDRESS_STREET = @"street";          //街道
const NSString *YK_KEY_ADDRESS_POSTCODE = @"postcode";      //邮编
const NSString *YK_KEY_PUSH_RECEIVE = @"isReceivePush";     //是否接受推送
const NSString *YK_KEY_FEEDBACK = @"feedback";              //反馈信息
const NSString *YK_KEY_SKUSTR = @"skuStr";                  //购物车商品的sku拼接字符串
const NSString *YK_KEY_COUPON_CODE = @"couponCode";         //优惠券号码
const NSString *YK_KEY_DELIVERY_TIME = @"deliveryTime";     //送货时间
const NSString *YK_KEY_SHIPPING_METHOD = @"shippingMethod"; //送货方式
const NSString *YK_KEY_HAS_INVOICE = @"hasInvoice";         //是否开发票
const NSString *YK_KEY_INVOICEHEADER = @"invoiceHeader";      //发票抬头
const NSString *YK_KEY_IS_USEBALANCE = @"isUseBalance";       //是否使用余额支付
const NSString *YK_KEY_PAYMENT_METHOD = @"paymentMethod";     //支付方式


#import "DataInterface.h"
#import "SunStringUtility.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface DataInterface(private)
+(void)initializeCommonParams;
+(void)initializeExtraHeaders;
@end


#import "DataInterface.h"

@implementation DataInterface


static NSMutableDictionary* s_commonParams;

+ (void)initialize{
    s_commonParams = [[NSMutableDictionary alloc] init];
    [[self class] initializeCommonParams];
}
+ (void)initializeCommonParams{
    CGFloat screenWidth = 320.0f;
	CGFloat screenHeight = 480.0f;
	UIScreen* _screen = [UIScreen mainScreen];
	
	if (isRetina) {
		UIScreenMode* _mode = [_screen currentMode];
		screenWidth = _mode.size.width;  
		screenHeight = _mode.size.height;  
	}
	[s_commonParams setValuesForKeysWithDictionary:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [NSString stringWithFormat:@"%.0f*%.0f", screenWidth, screenHeight], YK_KEY_SCREENSIZE,
      YK_VALUE_PLATFORM,YK_KEY_PLATFORM,
      [SunStringUtility strOrEmpty:[[[UIDevice currentDevice] macaddress] stringByReplacingOccurrencesOfString:@":" withString:@""]],YK_KEY_UDID,
      YK_VALUE_CLIENT_VER,YK_KEY_CLIENT_VER,
      YK_VALUE_PROTOCOL_VER,YK_KEY_PROTOCOL_VER,
      YK_VALUE_SOURCE_ID,YK_KEY_SOURCE_ID,
      YK_VALUE_SUBSOURCE_ID,YK_KEY_SUBSOURCE_ID,
      [SunStringUtility strOrEmpty:[[UIDevice currentDevice] model]],YK_KEY_MODEL,
      [[self class] getCarrierName],YK_KEY_CARRIER,
      nil]];
}
+(void)initializeExtraHeaders{
    /*
     参数名称			类型	是否可为空	说明										请求方式
     */
}
+(NSDictionary*)extraHeaders{
    return [NSDictionary dictionaryWithObjectsAndKeys:nil];
}
+(void) setCommonParam:(id)key value:(id)value{
    [s_commonParams setObject:value forKey:key];
    [[self class] walkDataInterface];
}
+(id) commonParam:(id) key{
    return [s_commonParams objectForKey:key];
}
+(NSMutableDictionary *)commonParams{
    return s_commonParams;
}
+(void)walkDataInterface{
	NSLog(@"= walkDataInterface =");
	for (id _k in [s_commonParams allKeys]) {
		NSLog(@"key:<%@>, value:<%@>",_k, [s_commonParams objectForKey:_k]);
	}
	NSLog(@"= end walkDataInterface =");
}
+(NSString*)sourceid{
    NSString *sourceidStr = (NSString *)[[NSUserDefaults standardUserDefaults]
                                         objectForKey:(NSString *)YK_KEY_SOURCE_ID];
    if (sourceidStr==nil) {
        [[NSUserDefaults standardUserDefaults] setValue:YK_VALUE_SOURCE_ID 
                                                 forKey:(NSString *)YK_KEY_SOURCE_ID];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return sourceidStr;
}
+(NSString *)getCarrierName{
	NSAutoreleasePool* pool=[[NSAutoreleasePool alloc] init];
	NSString* carrierName=nil;
	if (nil!=NSClassFromString(@"CTTelephonyNetworkInfo")){
		//
		CTTelephonyNetworkInfo* netInfo=[[CTTelephonyNetworkInfo alloc] init];
		if(netInfo!=nil){
			CTCarrier* carrier=netInfo.subscriberCellularProvider;
			if(carrier!=nil){
				carrierName=[carrier.carrierName copy];
			}
		}
		[netInfo autorelease];
	}
	[pool release];
	return [carrierName autorelease];
}


@end
