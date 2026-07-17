package com.controlcentre.masters.vehiclemaster.model;
import java.util.*;
public class ClsModelBean {
private int docno;
private String brand;
private String model;
private Date modeldate;
private String mode;
private String delete;
private int brandid;
private int txtgroupid;
private String txtgroup;

public int getTxtgroupid() {
	return txtgroupid;
}
public void setTxtgroupid(int txtgroupid) {
	this.txtgroupid = txtgroupid;
}
public String getTxtgroup() {
	return txtgroup;
}
public void setTxtgroup(String txtgroup) {
	this.txtgroup = txtgroup;
}
public int getBrandid() {
	return brandid;
}
public void setBrandid(int brandid) {
	this.brandid = brandid;
}
public String getModel() {
	return model;
}
public void setModel(String model) {
	this.model = model;
}
public String getMode() {
	return mode;
}
public void setMode(String mode) {
	this.mode = mode;
}
public String getDelete() {
	return delete;
}
public void setDelete(String delete) {
	this.delete = delete;
}
public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}
public String getBrand() {
	return brand;
}
public void setBrand(String brand) {
	this.brand = brand;
}
public Date getModeldate() {
	return modeldate;
}
public void setModeldate(Date modeldate) {
	this.modeldate = modeldate;
}




}
