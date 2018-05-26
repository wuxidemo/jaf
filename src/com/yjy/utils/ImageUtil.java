package com.yjy.utils;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.awt.image.ConvolveOp;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.awt.image.Kernel;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.imageio.ImageIO;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImageUtil {

	public static String ORIGINALPATH = "original";
	public static String PATH100 = "100x100";
	public static String TMPPATH = "TMP";

	/**
	 * 改变图片尺寸
	 * 
	 * @param imageSrc
	 * @param imageTarget
	 * @param width
	 * @param height
	 * @author shan
	 */
	public static void changeToSize(String imageSrc, String imageTarget,
			int width, int height, String formatName) {
		try {
			BufferedImage src = ImageIO.read(new File(imageSrc));
			Image image = src.getScaledInstance(width, height,
					Image.SCALE_DEFAULT);
			BufferedImage tag = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			Graphics g = tag.getGraphics();
			g.drawImage(image, 0, 0, null);
			g.dispose();
			ImageIO.write(tag, formatName, new File(imageTarget));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 描述：
	 * 
	 * @param path
	 *            需要压缩的图片路径
	 * @param toFileName
	 *            压缩后的图片路径
	 * @param width
	 *            压缩后的图片的宽度
	 * @param height
	 *            压缩后的图片的高度 返回值：void
	 */
	public static void imageCompress(String path, String toFileName, int width,
			int height) {
		try {
			float quality = 0.8f;// 压缩品质介于0.1~1.0之间
			// 原图路径 原图名称 目标路径 压缩比率0.5 0.75 原图宽度 原图高度
			Image image = javax.imageio.ImageIO.read(new File(path));
			int imageWidth = image.getWidth(null);
			int imageHeight = image.getHeight(null);
			float scale = 0.5f;// 默认压缩比为0.5，压缩比越大，对内存要去越高，可能导致内存溢出
			// 按比例计算出来的压缩比
			float realscale = getRatio(imageWidth, imageHeight, width, height);
			float finalScale = Math.min(scale, realscale);// 取压缩比最小的进行压缩
			imageWidth = (int) (finalScale * imageWidth);
			imageHeight = (int) (finalScale * imageHeight);

			image = image.getScaledInstance(imageWidth, imageHeight,
					Image.SCALE_AREA_AVERAGING);
			// Make a BufferedImage from the Image.
			BufferedImage mBufferedImage = new BufferedImage(imageWidth,
					imageHeight, BufferedImage.TYPE_INT_RGB);
			Graphics2D g2 = mBufferedImage.createGraphics();

			g2.drawImage(image, 0, 0, imageWidth, imageHeight, Color.white,
					null);
			g2.dispose();

			float[] kernelData2 = { -0.125f, -0.125f, -0.125f, -0.125f, 2,
					-0.125f, -0.125f, -0.125f, -0.125f };
			Kernel kernel = new Kernel(3, 3, kernelData2);
			ConvolveOp cOp = new ConvolveOp(kernel, ConvolveOp.EDGE_NO_OP, null);
			mBufferedImage = cOp.filter(mBufferedImage, null);

			FileOutputStream out = new FileOutputStream(toFileName);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			JPEGEncodeParam param = encoder
					.getDefaultJPEGEncodeParam(mBufferedImage);
			param.setQuality(quality, true);// 默认0.75
			encoder.setJPEGEncodeParam(param);
			encoder.encode(mBufferedImage);
			out.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
		}
	}

	private static float getRatio(int width, int height, int maxWidth,
			int maxHeight) {// 获得压缩比率的方法
		float Ratio = 1.0f;
		float widthRatio;
		float heightRatio;
		widthRatio = (float) maxWidth / width;
		heightRatio = (float) maxHeight / height;
		if (widthRatio < 1.0 || heightRatio < 1.0) {
			Ratio = widthRatio <= heightRatio ? widthRatio : heightRatio;
		}
		return Ratio;
	}

	/**
	 * 按较大宽高maxSize缩放
	 * 
	 * @param imageSrc
	 * @param imageTarget
	 * @param maxSize
	 * @param formatName
	 */
	public static void changeToSize(String imageSrc, String imageTarget,
			int maxSize, String formatName) {
		try {
			BufferedImage src = ImageIO.read(new File(imageSrc));
			int oriWidth = src.getWidth();
			int oriHeight = src.getHeight();
			int newWidth = oriWidth;
			int newHeight = oriHeight;
			if (oriWidth > 100 && oriWidth >= oriHeight) {
				double percent = (double) maxSize / oriWidth;
				newWidth = maxSize;
				newHeight = (int) (oriHeight * percent);
			} else if (oriHeight > 100 && oriHeight >= oriWidth) {
				double percent = (double) maxSize / newHeight;
				newHeight = maxSize;
				newWidth = (int) (oriWidth * percent);
			}
			Image image = src.getScaledInstance(newWidth, newHeight,
					Image.SCALE_DEFAULT);
			BufferedImage tag = new BufferedImage(newWidth, newHeight,
					BufferedImage.TYPE_INT_RGB);
			Graphics g = tag.getGraphics();
			g.drawImage(image, 0, 0, null);
			g.dispose();
			ImageIO.write(tag, formatName, new File(imageTarget));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * luyf 按较大宽高maxSize缩放
	 * 
	 * @param is
	 * @param imageTarget
	 * @param maxSize
	 * @param formatName
	 */
	public static void changeToSize(InputStream is, String imageTarget,
			int maxSize, String formatName) {
		try {
			BufferedImage src = ImageIO.read(is);
			int oriWidth = src.getWidth();
			int oriHeight = src.getHeight();
			int newWidth = oriWidth;
			int newHeight = oriHeight;
			if (oriWidth > 100 && oriWidth >= oriHeight) {
				double percent = (double) maxSize / oriWidth;
				newWidth = maxSize;
				newHeight = (int) (oriHeight * percent);
			} else if (oriHeight > 100 && oriHeight >= oriWidth) {
				double percent = (double) maxSize / newHeight;
				newHeight = maxSize;
				newWidth = (int) (oriWidth * percent);
			}
			Image image = src.getScaledInstance(newWidth, newHeight,
					Image.SCALE_DEFAULT);
			BufferedImage tag = new BufferedImage(newWidth, newHeight,
					BufferedImage.TYPE_INT_RGB);
			Graphics g = tag.getGraphics();
			g.drawImage(image, 0, 0, null);
			g.dispose();
			ImageIO.write(tag, formatName, new File(imageTarget));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void changeToSize(InputStream is, String imageTarget,
			int width, int height, String formatName) {
		try {
			BufferedImage src = ImageIO.read(is);
			Image image = src.getScaledInstance(width, height,
					Image.SCALE_DEFAULT);
			BufferedImage tag = new BufferedImage(width, height,
					BufferedImage.TYPE_INT_RGB);
			Graphics g = tag.getGraphics();
			g.drawImage(image, 0, 0, null);
			g.dispose();
			ImageIO.write(tag, formatName, new File(imageTarget));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		// changeToSize("C:\\test.jpg", "C:\\test_new.jpg", 100, "JPEG");
		// changeToSize("e:\\aas.jpg", "e:\\ssa.jpg", 100, "JPEG");

		// System.out.println(WeiChatUtil.accessToken("aaaa"));
		cutImage("jpg", "E:\\11.jpg", "E:\\112.jpg ", 10, 10, 100, 100);
	}

	public static void cutImage(String suffix, String sourcePath,
			String targetPath, int x1, int y1, int x2, int y2) {
		try {
			Image img;
			ImageFilter cropFilter;
			File sourceImgFile = new File(sourcePath);
			BufferedImage bi = ImageIO.read(sourceImgFile);
			int srcWidth = bi.getWidth();
			int srcHeight = bi.getHeight();
			int destWidth = x2 - x1;
			int destHeight = y2 - y1;
			if (srcWidth >= destWidth && srcHeight >= destHeight) {
				Image image = bi.getScaledInstance(srcWidth, srcHeight,
						Image.SCALE_DEFAULT);
				cropFilter = new CropImageFilter(x1, y1, destWidth, destHeight);
				img = Toolkit.getDefaultToolkit().createImage(
						new FilteredImageSource(image.getSource(), cropFilter));
				BufferedImage tag = new BufferedImage(destWidth, destHeight,
						BufferedImage.TYPE_INT_RGB);
				Graphics g = tag.getGraphics();
				g.drawImage(img, 0, 0, null);
				g.dispose();
				ImageIO.write(tag, suffix, new File(targetPath));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * 对字节数组字符串进行Base64解码并生成图片
	 * 
	 * @author lyf
	 * @date 2015年5月5日 上午11:12:51
	 * @param imgStr
	 * @param path
	 * @return
	 */
	public static boolean GenerateImage(String imgStr, String path) { //
		if (imgStr == null) // 图像数据为空
			return false;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			// Base64解码
			byte[] b = decoder.decodeBuffer(imgStr);
			for (int i = 0; i < b.length; ++i) {
				if (b[i] < 0) {// 调整异常数据
					b[i] += 256;
				}
			}
			// 生成jpeg图片
			OutputStream out = new FileOutputStream(path);
			out.write(b);
			out.flush();
			out.close();
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 
	 * 将图片文件转化为字节数组字符串，并对其进行Base64编码处理
	 * 
	 * @author lyf
	 * @date 2015年5月5日 上午11:13:02
	 * @return
	 */
	public static String GetImageStr() {// 
		String imgFile = "d://a.jpg";// 待处理的图片
		InputStream in = null;
		byte[] data = null;
		// 读取图片字节数组
		try {
			in = new FileInputStream(imgFile);
			data = new byte[in.available()];
			in.read(data);
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 对字节数组Base64编码
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(data);// 返回Base64编码过的字节数组字符串
	}
}
