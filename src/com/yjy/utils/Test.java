package com.yjy.utils;

import java.security.Key;
import java.security.SecureRandom;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

import org.apache.shiro.codec.Base64;


public class Test {
	
/*	static BASE64Decoder decoder = new BASE64Decoder();
	static BASE64Encoder encoder = new BASE64Encoder();

	static String DES = "DES";
	static String RSA = "RSA";

	static String encode = "UTF-8";// 保持平台兼容统一使用utf-8

	// 私钥文件路径
	static String privateFile = "/XXX/private_pkcs8_der.key";
	// 公钥文件路径
	static String publicFile = "/XXX/public_key.der";

	// des 加密
	private static byte[] encryptByteDES(byte[] byteD, String strKey) throws Exception {
		return doEncrypt(byteD, getKey(strKey), DES);
	}

	// des 解密
	private static byte[] decryptByteDES(byte[] byteD, String strKey) throws Exception {
		return doDecrypt(byteD, getKey(strKey), DES);
	}

	public static SecretKey getKey(String strKey) throws Exception {
		DESKeySpec desKeySpec = new DESKeySpec(strKey.getBytes());
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(DES);
		SecretKey sk = keyFactory.generateSecret(desKeySpec);
		return sk;
	}

	// pkcs8_der.key文件为私钥 只能保存在服务端
	// public_key.der为公钥文件，保存在客户端
	public static void main(String[] args) throws Exception {

		String text = "ceshishuuju测试数据ceshishuuju测试数据";
		String pwd = "12345678";
		// 客户端加密
		HashMap<String, String> data = DESAndRSAEncrypt(text.getBytes(encode), pwd);
		System.out.println("pwd RSA加密后base64：" + data.get("key"));
		System.out.println("text DES加密后base64：" + data.get("data"));

		// 服务端解密
		String textDecrypt = DESAndRSADecrypt(data);
		System.out.println("未处理原文：" + text);
		System.out.println("解密后数据：" + textDecrypt);
		// generateKeyPair();
	}

	// 客户端加密
	static HashMap<String, String> DESAndRSAEncrypt(byte[] dataToEncypt, String pwd) throws Exception {

		byte[] encryptData = encryptByteDES(dataToEncypt, pwd);
		String dataBase64 = encoder.encode(encryptData);

		byte[] encryptKey = RSAEncrypt(pwd.getBytes(encode));
		String keyBase64 = encoder.encode(encryptKey);

		HashMap<String, String> data = new HashMap<String, String>();
		data.put("data", dataBase64);
		data.put("key", keyBase64);
		return data;
	}

	// 服务端解密
	static String DESAndRSADecrypt(HashMap<String, String> data) throws Exception {
		String dataBase64 = data.get("data");
		String keyBase64 = data.get("key");

		byte[] encryptedData = decoder.decodeBuffer(dataBase64);
		byte[] encryptedKey = decoder.decodeBuffer(keyBase64);

		byte[] decryptedKey = RSADecrypt(encryptedKey);
		String pwd = new String(decryptedKey, encode);
		System.out.println("DES密码：" + pwd);

		byte[] decryptedData = decryptByteDES(encryptedData, pwd);
		String textDecrypt = new String(decryptedData, encode);
		return textDecrypt;
	}

	// 公钥加密
	public static byte[] RSAEncrypt(byte[] plainText) throws Exception {
		// 读取公钥
		CertificateFactory certificatefactory = CertificateFactory.getInstance("X.509");
		FileInputStream bais = new FileInputStream(publicFile);
		Certificate cert = certificatefactory.generateCertificate(bais);
		bais.close();
		PublicKey puk = cert.getPublicKey();
		// System.out.println("公钥base64："+encoder.encode(puk.getEncoded()));
		return doEncrypt(plainText, puk, RSA);
	}

	// 私钥解密
	public static byte[] RSADecrypt(byte[] encryptData) throws Exception {
		FileInputStream in = new FileInputStream(privateFile);
		ByteArrayOutputStream bout = new ByteArrayOutputStream();
		byte[] tmpbuf = new byte[1024];
		int count = 0;
		while ((count = in.read(tmpbuf)) != -1) {
			bout.write(tmpbuf, 0, count);
		}
		in.close();
		// 读取私钥
		KeyFactory keyFactory = KeyFactory.getInstance(RSA);
		PKCS8EncodedKeySpec privateKeySpec = new PKCS8EncodedKeySpec(bout.toByteArray());
		PrivateKey prk = keyFactory.generatePrivate(privateKeySpec);
		// System.out.println("私钥base64："+encoder.encode(prk.getPrivateExponent().toByteArray()));
		return doDecrypt(encryptData, prk, RSA);
	}

	*//**
	 * 执行加密操作
	 * 
	 * @param data
	 *            待操作数据
	 * @param key
	 *            Key
	 * @param type
	 *            算法 RSA or DES
	 * @return
	 * @throws Exception
	 *//*
	public static byte[] doEncrypt(byte[] data, Key key, String type) throws Exception {
		Cipher cipher = Cipher.getInstance(type);
		cipher.init(Cipher.ENCRYPT_MODE, key);
		return cipher.doFinal(data);
	}

	*//**
	 * 执行解密操作
	 * 
	 * @param data
	 *            待操作数据
	 * @param key
	 *            Key
	 * @param type
	 *            算法 RSA or DES
	 * @return
	 * @throws Exception
	 *//*
	public static byte[] doDecrypt(byte[] data, Key key, String type) throws Exception {
		Cipher cipher = Cipher.getInstance(type);
		cipher.init(Cipher.DECRYPT_MODE, key);
		return cipher.doFinal(data);
	}

	public static void generateKeyPair() throws Exception {
		KeyPairGenerator kpg = KeyPairGenerator.getInstance(RSA);
		kpg.initialize(1024); // 指定密钥的长度，初始化密钥对生成器
		KeyPair kp = kpg.generateKeyPair(); // 生成密钥对
		RSAPublicKey puk = (RSAPublicKey) kp.getPublic();
		RSAPrivateKey prk = (RSAPrivateKey) kp.getPrivate();
		BigInteger e = puk.getPublicExponent();
		BigInteger n = puk.getModulus();
		BigInteger d = prk.getPrivateExponent();

		BASE64Encoder encoder = new BASE64Encoder();
		System.out.println("public key:\n" + encoder.encode(n.toByteArray()));
		System.out.println("private key:\n" + encoder.encode(d.toByteArray()));
	}

	public String getMD5Code(String info) {
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.update(info.getBytes("UTF-8"));
			byte[] encryption = md5.digest();

			StringBuffer strBuf = new StringBuffer();
			for (int i = 0; i < encryption.length; i++) {
				if (Integer.toHexString(0xff & encryption[i]).length() == 1) {
					strBuf.append("0").append(Integer.toHexString(0xff & encryption[i]));
				} else {
					strBuf.append(Integer.toHexString(0xff & encryption[i]));
				}
			}

			return strBuf.toString();
		} catch (Exception e) {
			// TODO: handle exception
			return "";
		}

	}*/
	public static final String ALGORITHM_DES = "DES/CBC/PKCS5Padding";
	 
    /**
     * DES算法，加密
     *
     * @param data 待加密字符串
     * @param key  加密私钥，长度不能够小于8位
     * @return 加密后的字节数组，一般结合Base64编码使用
     * @throws CryptException 异常
     */
    public static String encode(String key,String data) throws Exception
    {
        return encode(key, data.getBytes());
    }
    /**
     * DES算法，加密
     *
     * @param data 待加密字符串
     * @param key  加密私钥，长度不能够小于8位
     * @return 加密后的字节数组，一般结合Base64编码使用
     * @throws CryptException 异常
     */
    public static String encode(String key,byte[] data) throws Exception
    {
        try
        {
            DESKeySpec dks = new DESKeySpec(key.getBytes());
             
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            //key的长度不能够小于8位字节
            Key secretKey = keyFactory.generateSecret(dks);
            Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
            IvParameterSpec iv = new IvParameterSpec("12345678".getBytes());
            AlgorithmParameterSpec paramSpec = iv;
            cipher.init(Cipher.ENCRYPT_MODE, secretKey,paramSpec);
             
            byte[] bytes = cipher.doFinal(data);
             
            return Base64.encode(bytes).toString();
        } catch (Exception e)
        {
            throw new Exception(e);
        }
    }
 
    /**
     * DES算法，解密
     *
     * @param data 待解密字符串
     * @param key  解密私钥，长度不能够小于8位
     * @return 解密后的字节数组
     * @throws Exception 异常
     */
    public static byte[] decode(String key,byte[] data) throws Exception
    {
        try
        {
            SecureRandom sr = new SecureRandom();
            DESKeySpec dks = new DESKeySpec(key.getBytes());
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            //key的长度不能够小于8位字节
            Key secretKey = keyFactory.generateSecret(dks);
            Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
            IvParameterSpec iv = new IvParameterSpec("12345678".getBytes());
            AlgorithmParameterSpec paramSpec = iv;
            cipher.init(Cipher.DECRYPT_MODE, secretKey,paramSpec);
            return cipher.doFinal(data);
        } catch (Exception e)
        {
            throw new Exception(e);
        }
    }
     
    /**
     * 获取编码后的值
     * @param key
     * @param data
     * @return
     * @throws Exception
     */
    public static String decodeValue(String key,String data) 
    {
        byte[] datas;
        String value = null;
        try {
            if(System.getProperty("os.name") != null && (System.getProperty("os.name").equalsIgnoreCase("sunos") || System.getProperty("os.name").equalsIgnoreCase("linux")))
            {
                datas = decode(key, Base64.decode(data));
            }
            else
            {
                datas = decode(key, Base64.decode(data));
            }
             
            value = new String(datas);
        } catch (Exception e) {
            value = "";
        }
        return value;
    }
 
    /**
    * test 
    * @param key : 12345678
    */
    public static void main(String[] args) throws Exception
    {
         String aa = encode("12345678","cychai");
        System.out.println("明：cychai ；密：" + aa);
        System.out.println("密：cychai ；明：" + decodeValue("12345678", "[B@5b21ae2"));
    }
}
