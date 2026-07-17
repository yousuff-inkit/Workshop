package com.workshop.workshopsetup.bay;
import java.util.*;
public class ClsBayBean {


private int docno;
private String baydate;
private String code;
private String name;
 

private String hidbaydate;
private String mode;
private String delete;


public String getBaydate() {
	return baydate;
}
public void setBaydate(String baydate) {
	this.baydate = baydate;
}
public String getHidbaydate() {
	return hidbaydate;
}
public void setHidbaydate(String hidbaydate) {
	this.hidbaydate = hidbaydate;
}
private String hidacno;

public String getHidacno() {
	return hidacno;
}
public void setHidacno(String hidacno) {
	this.hidacno = hidacno;
}





public int getDocno() {
	return docno;
}
public void setDocno(int docno) {
	this.docno = docno;
}

public String getCode() {
	return code;
}
public void setCode(String code) {
	this.code = code;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
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




}