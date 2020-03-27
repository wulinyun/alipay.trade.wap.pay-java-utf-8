<%@page import="com.alipay.api.internal.util.AlipaySignature"%>
<%
/* *
 功能：支付宝页面跳转同步通知页面
 版本：3.2
 日期：2011-03-17
 说明：
 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。

 //***********页面功能说明***********
 该页面可在本机电脑测试
 可放入HTML等美化页面的代码、商户业务逻辑程序代码
 TRADE_FINISHED(表示交易已经成功结束，并不能再对该交易做后续操作);
 TRADE_SUCCESS(表示交易已经成功结束，可以对该交易做后续操作，如：分润、退款等);
 //********************************
 * */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.alipay.config.*"%>
<%@ page import="com.alipay.api.*"%>
<html>
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>支付宝页面跳转同步通知页面</title>
  </head>
  <body>
<%
	/**
	 * return_url:charset=UTF-8
	 * return_url:out_trade_no=202032717520632
	 * return_url:method=alipay.trade.wap.pay.return
	 * return_url:total_amount=0.01
	 * return_url:sign=fUJ3UBG66/N3r16nBykE3v/M2C1wTq+OnH8HQq3nMpJuJBXZiCDQ61A6oNmWEQVQSJgy7d8PQWeMULoHtN1C4i8IYO8j1WDY7Wmx2f26XfqOgKMMcPxRQxAKM1k3z23js5hzvZboo6/cZL
	 * Ir/3weN74Kt7Spc/Wmpc8YdnNM92VnxLQfYJ3X5vWfitB0i5GAK6riwhz1YHk6AEo6nFYP53E5mTb+McD5qLozyKl6hQVkAFL948ZIOuuv3ZZcx1/8ylHojDhdoQlwdIorTH41ve7q0xQ2yrdVIMPNYhMYcUgerr3qEcSBZwbE/qb8Fojv/AfwUqyfAsla/sgGFCM1Gg==
	 * return_url:trade_no=2020032722001452341437024925
	 * return_url:auth_app_id=2021001146601279
	 * return_url:version=1.0
	 * return_url:app_id=2021001146601279
	 * return_url:sign_type=RSA2
	 * return_url:seller_id=2088731909746398
	 * return_url:timestamp=2020-03-27 17:05:33
	 * return_url:out_trade_no=202032717520632
	 * return_url:trade_no=2020032722001452341437024925
	 * return_url:verify_result=true
	 */
	//获取支付宝GET过来反馈信息
	Map<String,String> params = new HashMap<String,String>();
	Map requestParams = request.getParameterMap();
	for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		String name = (String) iter.next();
		String[] values = (String[]) requestParams.get(name);
		String valueStr = "";
		for (int i = 0; i < values.length; i++) {
			valueStr = (i == values.length - 1) ? valueStr + values[i]
					: valueStr + values[i] + ",";
		}
		//乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
		valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		System.out.println("return_url:"+name+"="+valueStr);
		params.put(name, valueStr);
	}
	
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
	//商户订单号

	String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
	System.out.println("return_url:out_trade_no="+out_trade_no);
	//支付宝交易号

	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
	System.out.println("return_url:trade_no="+trade_no);
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
	//计算得出通知验证结果
	//boolean AlipaySignature.rsaCheckV1(Map<String, String> params, String publicKey, String charset, String sign_type)
	boolean verify_result = AlipaySignature.rsaCheckV1(params, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.CHARSET, "RSA2");
	System.out.println("return_url:verify_result="+verify_result);
	if(verify_result){//验证成功
		//////////////////////////////////////////////////////////////////////////////////////////
		//请在这里加上商户的业务逻辑程序代码
		//该页面可做页面美工编辑
		out.clear();
		out.println("验证成功<br />");
		//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

		//////////////////////////////////////////////////////////////////////////////////////////
	}else{
		//该页面可做页面美工编辑
		out.clear();
		out.println("验证失败");
	}
%>
  </body>
</html>