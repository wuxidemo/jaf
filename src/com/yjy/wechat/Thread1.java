package com.yjy.wechat;

public class Thread1 implements Runnable {

	public void run() {
		synchronized (this) {
			for (int i = 0; i < 5; i++) {
				mytest.num = i;
				System.out.println(Thread.currentThread().getName()
						+ " synchronized loop " + i + "  num:" + mytest.num);
			}
		}

	}

	public static void main(String[] args) {
		Thread1 t1 = new Thread1();
		Thread ta = new Thread(t1, "A");
		Thread tb = new Thread(t1, "B");
		ta.start();
		tb.start();
	}
}
