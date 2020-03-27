<%@page import="com.alipay.api.internal.util.AlipaySignature"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.alipay.config.*"%>
<%@ page import="com.alipay.api.*"%>
<%
	/**
	 * 支付成功
	 * notify_url:gmt_create=2020-03-27 18:12:45
	 * notify_url:charset=UTF-8
	 * notify_url:seller_email=linyun.wu@sagesoft.cn
	 * notify_url:subject=手机网站支付测试商品
	 * notify_url:sign=B/oD/2cOmuqOQf4R7yQf3s/0Yps8gQ6Hi7o+K0IhOhjgAMXTaCaNC2cz+Emd4tvTbPgbwJwluGLWadcoALJFmAjRGGAfNX4huZ0uyXnrQQgLO4wCkQOra4z0Rjl6Q6AzYBH0OFVui/GDZm
	 * VEVYAqVsCiAnwCASj8jLVOrw3OZoK/0eoKHmHZj+EQSL5YgCu/rjLRsgYterNJvLJAdLQzxkBbnfeW0HlbNZJWu87x29sv6lqnXdipw5T8T2nQffvd39T1wVZoWXvKVzaM30tSSzOmVS+Xb397sLKHNEcuAy1GAfKCiGcD6x8LvxHJZlBOBkthdRbxRccFPDgk4hvOOw==notify_url:body=购买测试商品0.01元
	 * notify_url:buyer_id=2088312718052342
	 * notify_url:invoice_amount=0.01
	 * notify_url:notify_id=2020032700222181246052341404336738
	 * notify_url:fund_bill_list=[{"amount":"0.01","fundChannel":"ALIPAYACCOUNT"}]
	 * notify_url:notify_type=trade_status_sync
	 * notify_url:trade_status=TRADE_SUCCESS
	 * notify_url:receipt_amount=0.01
	 * notify_url:buyer_pay_amount=0.01
	 * notify_url:app_id=2021001146601279
	 * notify_url:sign_type=RSA2
	 * notify_url:seller_id=2088731909746398
	 * notify_url:gmt_payment=2020-03-27 18:12:46
	 * notify_url:notify_time=2020-03-27 18:12:46
	 * notify_url:version=1.0
	 * notify_url:out_trade_no=2020327181224259
	 * notify_url:total_amount=0.01
	 * notify_url:trade_no=2020032722001452341437284085
	 * notify_url:auth_app_id=2021001146601279
	 * notify_url:buyer_logon_id=147***@qq.com
	 * notify_url:point_amount=0.00
	 * notify_url:out_trade_no=2020327181224259
	 * notify_url:trade_no=2020032722001452341437284085
	 * notify_url:trade_status=TRADE_SUCCESS
	 * notify_url:verify_result=true
	 *
	 * 退款成功
	 * notify_url:gmt_create=2020-03-27 18:12:45
	 * notify_url:charset=UTF-8
	 * notify_url:seller_email=linyun.wu@sagesoft.cn
	 * notify_url:subject=手机网站支付测试商品
	 * notify_url:sign=kNJ0ajY7eT6WRv/Pi/gNkhqP+iRtnroFrBnYORfJhwbYcQXqj4nAhiC90vFDFIQy56kG35Z4fogS5y6hc+9aXzWC0F+ngu+Zh0KA+cj535+9XznOOCa0nRaIqVnCgRDMyHpZ+92LrixbIK
	 * EXCucLA5S5GuVeTsO5MPHlN4f/aHKwfuvUrMw8sIse11VlF2Mh9yUOOIw8U1KPX0ONRSgMXCrQ+pEmOGi/nU0JhE4/F6v7PgpRe3QN4uujJxXqpbShfygEchE1iGig9jDALJW9b5S6Uwfmixxw0FnFeVmT/FErz1eO64mIzoga6izYyMFdL/hVIu6bAeE7N9i0siPjyw==
	 * notify_url:body=购买测试商品0.01元
	 * notify_url:buyer_id=2088312718052342
	 * notify_url:notify_id=2020032700222181915052341404297126
	 * notify_url:notify_type=trade_status_sync
	 * notify_url:trade_status=TRADE_CLOSED
	 * notify_url:app_id=2021001146601279
	 * notify_url:sign_type=RSA2
	 * notify_url:seller_id=2088731909746398
	 * notify_url:gmt_payment=2020-03-27 18:12:46
	 * notify_url:notify_time=2020-03-27 18:19:15
	 * notify_url:gmt_refund=2020-03-27 18:19:15.143
	 * notify_url:out_biz_no=2020032722001452341437284085
	 * notify_url:version=1.0
	 * notify_url:out_trade_no=2020327181224259
	 * notify_url:total_amount=0.01
	 * notify_url:refund_fee=0.01
	 * notify_url:trade_no=2020032722001452341437284085
	 * notify_url:auth_app_id=2021001146601279
	 * notify_url:buyer_logon_id=147***@qq.com
	 * notify_url:gmt_close=2020-03-27 18:19:15
	 * notify_url:out_trade_no=2020327181224259
	 * notify_url:trade_no=2020032722001452341437284085
	 * notify_url:trade_status=TRADE_CLOSED
	 * notify_url:verify_result=true
	 */
	//获取支付宝POST过来反馈信息
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
		//valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
		System.out.println("notify_url:"+name+"="+valueStr);
		params.put(name, valueStr);
	}
	//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		//商户订单号

		String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
		System.out.println("notify_url:out_trade_no="+out_trade_no);
		//支付宝交易号

		String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
	    System.out.println("notify_url:trade_no="+trade_no);
		//交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
	    System.out.println("notify_url:trade_status="+trade_status);
		//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
		//计算得出通知验证结果
		//boolean AlipaySignature.rsaCheckV1(Map<String, String> params, String publicKey, String charset, String sign_type)
		boolean verify_result = AlipaySignature.rsaCheckV1(params, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.CHARSET, "RSA2");
	    System.out.println("notify_url:verify_result="+verify_result);
		if(verify_result){//验证成功
			//////////////////////////////////////////////////////////////////////////////////////////
			//请在这里加上商户的业务逻辑程序代码

			//——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
			
			if(trade_status.equals("TRADE_FINISHED")){
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
					//如果有做过处理，不执行商户的业务程序
					
				//注意：
				//如果签约的是可退款协议，退款日期超过可退款期限后（如三个月可退款），支付宝系统发送该交易状态通知
				//如果没有签约可退款协议，那么付款完成后，支付宝系统发送该交易状态通知。
			} else if (trade_status.equals("TRADE_SUCCESS")){
				//判断该笔订单是否在商户网站中已经做过处理
					//如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					//请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
					//如果有做过处理，不执行商户的业务程序
					
				//注意：
				//如果签约的是可退款协议，那么付款完成后，支付宝系统发送该交易状态通知。
			}

			//——请根据您的业务逻辑来编写程序（以上代码仅作参考）——
			out.clear();
			out.println("success");	//请不要修改或删除

			//////////////////////////////////////////////////////////////////////////////////////////
		}else{//验证失败
			out.println("fail");
		}
%>
