DELIMITER $$

DROP PROCEDURE IF EXISTS `gateInPassDML` $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `gateInPassDML`(

in  vdocdate       date,
    vfleetno       mediumint(8),
    vhiddriver     mediumint(8),
    vchkdriver     mediumint(8),
    vdrivername    varchar(45),
    vindate        date,
    vintime        varchar(5),
    vinkm          decimal(15,4),
    vinfuel        decimal(15,3),
    vremarks       varchar(300),
    vdtype         varchar(5),
    vmode          varchar(5),
    vuserid        mediumint(8),
    vbranchid      mediumint(8),
    vserviceduekm  mediumint(8),
inout  docNo       mediumint(8),
in  vagmtno        mediumint(8),
    vcldocno       mediumint(8)

)
BEGIN
  declare vsrvckm decimal(15,4);
  declare vlastsrvckm decimal(15,4);

  select srvc_km,lst_srv into vsrvckm,vlastsrvckm from gl_vehmaster where fleet_no=vfleetno and statu=3;
if(vmode='A') then
    select coalesce(max(doc_no)+1,1) into docNo from gl_workgateinpassm where brhid=vbranchid;

    insert into gl_workgateinpassm(doc_no,brhid,userid,date,fleet_no,driverid,newdriver,drivername,indate,intime,inkm,infuel,
    remarks,serviceduekm,status,srvckm,lastsrvckm,srvcduediff,agmtno,cldocno)values(docno,vbranchid,vuserid,vdocdate,vfleetno,vhiddriver,vchkdriver,vdrivername,vindate,
    vintime,vinkm,vinfuel,vremarks,vserviceduekm,3,vsrvckm,vlastsrvckm,vinkm-(vsrvckm+vlastsrvckm),vagmtno,vcldocno);

    insert into datalog (doc_no,brhId,dtype,edate,userId,ENTRY)values(docNo,vbranchid,vdtype,now(),vuserid,vmode);

    update gl_vehmaster set lst_srv=vinkm where fleet_no=vfleetno and statu=3;
elseif(vmode='E') then

    update gl_workgateinpassm set fleet_no=vfleetno,driverid=vhiddriver,newdriver=vchkdriver,drivername=vdrivername,indate=vindate,
    intime=vintime,inkm=vinkm,infuel=vinfuel,remarks=vremarks,serviceduekm=vserviceduekm,srvckm=vsrvckm,lastsrvckm=vlastsrvckm,
    srvcduediff=(vinkm-(vsrvckm+vlastsrvckm)),agmtno=vagmtno,cldocno=vcldocno where doc_no=docNo and brhid=vbranchid;

    insert into datalog (doc_no,brhId,dtype,edate,userId,ENTRY)values(docNo,vbranchid,vdtype,now(),vuserid,vmode);

    update gl_vehmaster set lst_srv=vinkm where fleet_no=vfleetno and statu=3;

elseif(vmode='D') then

    update gl_workgateinpassm set status=7 where  doc_no=docNo and brhid=vbranchid;

    insert into datalog (doc_no,brhId,dtype,edate,userId,ENTRY)values(docNo,vbranchid,vdtype,now(),vuserid,vmode);

end if;

END $$

DELIMITER ;