package com.duyi.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * @description: 信息加密工具类
 * @author: wang
 * @time: 2024/5/14 8:31
 */
public class Md5Util {
/** 可以把密码 加工 MD5形式的 */
	public  static String  md5Str(String password){
		// "a" + "b" + "c" + "d"
		StringBuffer  strBuf = new StringBuffer();
		try {
			MessageDigest md =  MessageDigest.getInstance("MD5");
			md.update(password.getBytes());
			// 得到md5 形式的一个byte 数组  长度是16
			byte[] md5Bytes = md.digest();

			// 把每个byte 分成 2 个16进制数 再拼接成字符串
			for(int i=0;i<md5Bytes.length;i++){
				byte md5Byte = md5Bytes[i];
				// 1byte 是 8bit 但是 一个int 是 32bit  4bit可以表示一个16进制数
				String  tempStr = Integer.toHexString(md5Byte&0xff);
				//System.out.println(tempStr);
				if(tempStr.length()==1){
					tempStr = "0"+tempStr;
				}
				strBuf.append(tempStr);
			}
			return  strBuf.toString();
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return password;
	}
	/** 可以把密码 加工 MD5形式的  并且加盐 较为简单 容易破解*/
//	public  static String  md5StrAndSalt(String password,String salt){
//		password = password + salt;
//		// "a" + "b" + "c" + "d"
//		StringBuffer  strBuf = new StringBuffer();
//		try {
//			MessageDigest  md =  MessageDigest.getInstance("MD5");
//			md.update(password.getBytes());
//			// 得到md5 形式的一个byte 数组  长度是16
//			byte[] md5Bytes = md.digest();
//
//			// 把每个byte 分成 2 个16进制数 再拼接成字符串
//			for(int i=0;i<md5Bytes.length;i++){
//				byte md5Byte = md5Bytes[i];
//				// 1byte 是 8bit 但是 一个int 是 32bit  4bit可以表示一个16进制数
//				String  tempStr = Integer.toHexString(md5Byte&0xff);
//				//System.out.println(tempStr);
//				if(tempStr.length()==1){
//					tempStr = "0"+tempStr;
//				}
//				strBuf.append(tempStr);
//			}
//			return  strBuf.toString();
//		} catch (NoSuchAlgorithmException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return password;
//	}

	//password的偶数位和salt的奇数位拼接成的加密信息，加密信息不可逆（不可解码）
	public  static String  md5Salt(String password,String salt){

		byte[] value = new byte[32];
		byte[] passwordMD5 = md5Str(password).getBytes();

		byte[] saltMD5 = md5Str(salt).getBytes();

		for (int i = 0; i < passwordMD5.length; i++) {
			if (i % 2 == 0) {
				//偶数位
				value[i] = passwordMD5[i];
			}
			if (i%2==1){
				//奇数位
				value[i] = saltMD5[i];
			}
		}
		return new String(value);
	}

}
