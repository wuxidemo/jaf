/**
 * LinkWSSoap.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.tempuri;

public interface LinkWSSoap extends java.rmi.Remote {
    public java.lang.String helloWorld() throws java.rmi.RemoteException;
    public int batchSend(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String content, java.lang.String cell, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String getReportFail(java.lang.String corpID, java.lang.String pwd, java.lang.String cell) throws java.rmi.RemoteException;
    public int reg(java.lang.String corpID, java.lang.String pwd, java.lang.String corpName, java.lang.String linkMan, java.lang.String tel, java.lang.String mobile, java.lang.String email, java.lang.String memo) throws java.rmi.RemoteException;
    public int updPwd(java.lang.String corpID, java.lang.String pwd, java.lang.String newPwd) throws java.rmi.RemoteException;
    public int updReg(java.lang.String corpID, java.lang.String pwd, java.lang.String corpName, java.lang.String linkMan, java.lang.String tel, java.lang.String mobile, java.lang.String email, java.lang.String memo) throws java.rmi.RemoteException;
    public int selSum(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException;
    public int send(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String content, java.lang.String cell, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String get(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException;
    public int unReg(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException;
    public int chargeUp(java.lang.String corpID, java.lang.String pwd, java.lang.String cardNo, java.lang.String cardPwd) throws java.rmi.RemoteException;
    public java.lang.String agentChangeAccount(java.lang.String loginName, java.lang.String loginPwd, java.lang.String corpID, int smsBalance, int mmsBalance) throws java.rmi.RemoteException;
    public java.lang.String balanceMMS(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException;
    public java.lang.String sendMMS(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String base64Content, java.lang.String title, java.lang.String extCode, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String batchSendMMS(java.lang.String corpID, java.lang.String pwd, java.lang.String mobiles, java.lang.String base64Content, java.lang.String title, java.lang.String extCode, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String getReportFailMMS(java.lang.String corpID, java.lang.String pwd, java.lang.String cell) throws java.rmi.RemoteException;
    public java.lang.String getMMS(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException;
    public java.lang.String chargeUpMMS(java.lang.String corpID, java.lang.String pwd, java.lang.String cardNo, java.lang.String cardPwd) throws java.rmi.RemoteException;
    public java.lang.String agentMakeAccount(java.lang.String loginName, java.lang.String loginPwd, java.lang.String corpName, java.lang.String linkMan, java.lang.String tel, java.lang.String mobile, java.lang.String email, java.lang.String memo, java.lang.String corpID, java.lang.String pass) throws java.rmi.RemoteException;
    public java.lang.String getReportSMS(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException;
    public java.lang.String getReportMMS(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException;
    public java.lang.String send2(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String content, java.lang.String cell, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String sendMMS2(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String base64Content, java.lang.String title, java.lang.String extCode, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String batchSend2(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String content, java.lang.String cell, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String batchSendMMS2(java.lang.String corpID, java.lang.String pwd, java.lang.String mobiles, java.lang.String base64Content, java.lang.String title, java.lang.String extCode, java.lang.String sendTime) throws java.rmi.RemoteException;
    public java.lang.String voiceNotify(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String verify_code, java.lang.String vtpl_id, java.lang.String show_num) throws java.rmi.RemoteException;
    public java.lang.String notSend(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException;
}
