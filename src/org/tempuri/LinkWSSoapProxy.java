package org.tempuri;

public class LinkWSSoapProxy implements org.tempuri.LinkWSSoap {
  private String _endpoint = null;
  private org.tempuri.LinkWSSoap linkWSSoap = null;
  
  public LinkWSSoapProxy() {
    _initLinkWSSoapProxy();
  }
  
  public LinkWSSoapProxy(String endpoint) {
    _endpoint = endpoint;
    _initLinkWSSoapProxy();
  }
  
  private void _initLinkWSSoapProxy() {
    try {
      linkWSSoap = (new org.tempuri.LinkWSLocator()).getLinkWSSoap();
      if (linkWSSoap != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)linkWSSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)linkWSSoap)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (linkWSSoap != null)
      ((javax.xml.rpc.Stub)linkWSSoap)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public org.tempuri.LinkWSSoap getLinkWSSoap() {
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap;
  }
  
  public java.lang.String helloWorld() throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.helloWorld();
  }
  
  public int batchSend(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String content, java.lang.String cell, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.batchSend(corpID, pwd, mobile, content, cell, sendTime);
  }
  
  public java.lang.String getReportFail(java.lang.String corpID, java.lang.String pwd, java.lang.String cell) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.getReportFail(corpID, pwd, cell);
  }
  
  public int reg(java.lang.String corpID, java.lang.String pwd, java.lang.String corpName, java.lang.String linkMan, java.lang.String tel, java.lang.String mobile, java.lang.String email, java.lang.String memo) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.reg(corpID, pwd, corpName, linkMan, tel, mobile, email, memo);
  }
  
  public int updPwd(java.lang.String corpID, java.lang.String pwd, java.lang.String newPwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.updPwd(corpID, pwd, newPwd);
  }
  
  public int updReg(java.lang.String corpID, java.lang.String pwd, java.lang.String corpName, java.lang.String linkMan, java.lang.String tel, java.lang.String mobile, java.lang.String email, java.lang.String memo) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.updReg(corpID, pwd, corpName, linkMan, tel, mobile, email, memo);
  }
  
  public int selSum(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.selSum(corpID, pwd);
  }
  
  public int send(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String content, java.lang.String cell, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.send(corpID, pwd, mobile, content, cell, sendTime);
  }
  
  public java.lang.String get(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.get(corpID, pwd);
  }
  
  public int unReg(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.unReg(corpID, pwd);
  }
  
  public int chargeUp(java.lang.String corpID, java.lang.String pwd, java.lang.String cardNo, java.lang.String cardPwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.chargeUp(corpID, pwd, cardNo, cardPwd);
  }
  
  public java.lang.String agentChangeAccount(java.lang.String loginName, java.lang.String loginPwd, java.lang.String corpID, int smsBalance, int mmsBalance) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.agentChangeAccount(loginName, loginPwd, corpID, smsBalance, mmsBalance);
  }
  
  public java.lang.String balanceMMS(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.balanceMMS(corpID, pwd);
  }
  
  public java.lang.String sendMMS(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String base64Content, java.lang.String title, java.lang.String extCode, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.sendMMS(corpID, pwd, mobile, base64Content, title, extCode, sendTime);
  }
  
  public java.lang.String batchSendMMS(java.lang.String corpID, java.lang.String pwd, java.lang.String mobiles, java.lang.String base64Content, java.lang.String title, java.lang.String extCode, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.batchSendMMS(corpID, pwd, mobiles, base64Content, title, extCode, sendTime);
  }
  
  public java.lang.String getReportFailMMS(java.lang.String corpID, java.lang.String pwd, java.lang.String cell) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.getReportFailMMS(corpID, pwd, cell);
  }
  
  public java.lang.String getMMS(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.getMMS(corpID, pwd);
  }
  
  public java.lang.String chargeUpMMS(java.lang.String corpID, java.lang.String pwd, java.lang.String cardNo, java.lang.String cardPwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.chargeUpMMS(corpID, pwd, cardNo, cardPwd);
  }
  
  public java.lang.String agentMakeAccount(java.lang.String loginName, java.lang.String loginPwd, java.lang.String corpName, java.lang.String linkMan, java.lang.String tel, java.lang.String mobile, java.lang.String email, java.lang.String memo, java.lang.String corpID, java.lang.String pass) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.agentMakeAccount(loginName, loginPwd, corpName, linkMan, tel, mobile, email, memo, corpID, pass);
  }
  
  public java.lang.String getReportSMS(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.getReportSMS(corpID, pwd);
  }
  
  public java.lang.String getReportMMS(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.getReportMMS(corpID, pwd);
  }
  
  public java.lang.String send2(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String content, java.lang.String cell, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.send2(corpID, pwd, mobile, content, cell, sendTime);
  }
  
  public java.lang.String sendMMS2(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String base64Content, java.lang.String title, java.lang.String extCode, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.sendMMS2(corpID, pwd, mobile, base64Content, title, extCode, sendTime);
  }
  
  public java.lang.String batchSend2(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String content, java.lang.String cell, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.batchSend2(corpID, pwd, mobile, content, cell, sendTime);
  }
  
  public java.lang.String batchSendMMS2(java.lang.String corpID, java.lang.String pwd, java.lang.String mobiles, java.lang.String base64Content, java.lang.String title, java.lang.String extCode, java.lang.String sendTime) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.batchSendMMS2(corpID, pwd, mobiles, base64Content, title, extCode, sendTime);
  }
  
  public java.lang.String voiceNotify(java.lang.String corpID, java.lang.String pwd, java.lang.String mobile, java.lang.String verify_code, java.lang.String vtpl_id, java.lang.String show_num) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.voiceNotify(corpID, pwd, mobile, verify_code, vtpl_id, show_num);
  }
  
  public java.lang.String notSend(java.lang.String corpID, java.lang.String pwd) throws java.rmi.RemoteException{
    if (linkWSSoap == null)
      _initLinkWSSoapProxy();
    return linkWSSoap.notSend(corpID, pwd);
  }
  
  
}