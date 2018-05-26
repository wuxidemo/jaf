/**
 * LinkWSLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package org.tempuri;

public class LinkWSLocator extends org.apache.axis.client.Service implements org.tempuri.LinkWS {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public LinkWSLocator() {
    }


    public LinkWSLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public LinkWSLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for LinkWSSoap
    private java.lang.String LinkWSSoap_address = "http://mb345.com:999/ws/LinkWS.asmx";

    public java.lang.String getLinkWSSoapAddress() {
        return LinkWSSoap_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String LinkWSSoapWSDDServiceName = "LinkWSSoap";

    public java.lang.String getLinkWSSoapWSDDServiceName() {
        return LinkWSSoapWSDDServiceName;
    }

    public void setLinkWSSoapWSDDServiceName(java.lang.String name) {
        LinkWSSoapWSDDServiceName = name;
    }

    public org.tempuri.LinkWSSoap getLinkWSSoap() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(LinkWSSoap_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getLinkWSSoap(endpoint);
    }

    public org.tempuri.LinkWSSoap getLinkWSSoap(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            org.tempuri.LinkWSSoapStub _stub = new org.tempuri.LinkWSSoapStub(portAddress, this);
            _stub.setPortName(getLinkWSSoapWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setLinkWSSoapEndpointAddress(java.lang.String address) {
        LinkWSSoap_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (org.tempuri.LinkWSSoap.class.isAssignableFrom(serviceEndpointInterface)) {
                org.tempuri.LinkWSSoapStub _stub = new org.tempuri.LinkWSSoapStub(new java.net.URL(LinkWSSoap_address), this);
                _stub.setPortName(getLinkWSSoapWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("LinkWSSoap".equals(inputPortName)) {
            return getLinkWSSoap();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://tempuri.org/", "LinkWS");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://tempuri.org/", "LinkWSSoap"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("LinkWSSoap".equals(portName)) {
            setLinkWSSoapEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
