
<%@page import="com.operations.agreement.leaseclose.ClsLeaseCloseDAO"%>
<style>
.column2{
background-color: #FFEEDC;
}
</style>
<%@page import="com.common.ClsCommon"%>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
ClsLeaseCloseDAO leasedao=new ClsLeaseCloseDAO();
ClsCommon objcommon=new ClsCommon();
String useddays=request.getParameter("useddays")==null?"0":request.getParameter("useddays");
String usedhours=request.getParameter("usedhours")==null?"0":request.getParameter("usedhours");
String totalkm=request.getParameter("totalkm")==null?"0":request.getParameter("totalkm");
String excesskm=request.getParameter("excesskm")==null?"0":request.getParameter("excesskm");
String agmtno=request.getParameter("agmtno")==null?"0":request.getParameter("agmtno");
String rentaltype="";
String agmtdate=request.getParameter("agmtdate")==null?"0":request.getParameter("agmtdate");
String closedate=request.getParameter("closedate")==null?"0":request.getParameter("closedate");
String temp=request.getParameter("temp")==null?"0":request.getParameter("temp");
System.out.println("Useddays"+useddays+"Hours"+usedhours+"Totalkm"+totalkm+"ExcessKM"+excesskm+"Agmtno"+agmtno+"temp"+temp);
System.out.println("AgmtNo in Total Grid"+agmtno);
java.sql.Date closeinvdate=(request.getParameter("closeinvdate")==null || request.getParameter("closeinvdate")=="")?null:objcommon.changeStringtoSqlDate(request.getParameter("closeinvdate"));
%>
<script type="text/javascript">
      var datatotal;
      var temp1='<%=temp%>';
    //alert("total:"+temp1);
        $(document).ready(function () { 	
            
        	 var columnsrenderer = function (value) {
        			return '<div style="text-align: center;margin-top: 5px;">' + value + '</div>';
        		}
        	   
            if((temp1=="1")&&(document.getElementById("docno").value=="")){
            	
            datatotal='<%=leasedao.getTotalData(useddays,usedhours,totalkm,excesskm,agmtno,rentaltype,agmtdate,closedate,closeinvdate)%>';
            }
            else if(temp1=="2" && document.getElementById("docno").value!=""){
            	datatotal='<%=leasedao.getTotalData_view(agmtno)%>';
            }
           
            var num = 0;
        	var rowEdit = function (row) {
        	    if (row == 1  )
        	        return true;
        	  
        	}
            var source =
            {
                datatype: "json",
                datafields: [

{name : 'rentaltype' , type: 'string' },
	{name : 'rate' , type:'number'},
	{name : 'cdw' , type:'number'},
	{name : 'pai' , type:'number'},
	{name : 'cdw1' , type:'number'},
	{name : 'pai1' , type:'number'},
	{name : 'gps' , type:'number'},
	{name : 'babyseater' , type:'number'},
	{name : 'cooler' , type:'number'},
	{name : 'exhrchg' , type:'number'},
	{name : 'chaufchg' , type:'number'},
	{name : 'exkmrte' , type:'number'},
	{name : 'excesskm', type:'number'},
	{name : 'termamt', type:'number'},
	{name : 'termmonth',type:'number'},
	{name : 'calctype', type:'string'}
	
                 ],
                localdata: datatotal,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };

            $("#totalgrid").on("bindingcomplete", function (event) {
            	//var rowindex1=event.args.rowindex;
            	if(document.getElementById("mode").value=='A'){
            		//alert("Exxcesskm:"+$('#totalgrid').jqxGrid('getcellvalue', 2, "excesskm"));
            	document.getElementById("excesskm").value=$('#totalgrid').jqxGrid('getcellvalue', 2, "excesskm");	
            	document.getElementById("termamt").value=$('#totalgrid').jqxGrid('getcellvalue', 2, "termamt");
            	document.getElementById("termmonth").value=$('#totalgrid').jqxGrid('getcellvalue', 2, "termmonth");
				document.getElementById("calctype").value=$('#totalgrid').jqxGrid('getcellvalue', 2, "calctype");
            	//alert("inside total grid"+document.getElementById("termamt").value);
            	}
            	});  
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#totalgrid").jqxGrid(
            {
                width: '100%',
                height: 80,
                rowsheight:18,
                source: dataAdapter,
                columnsresize: true,
                localization: {thousandsSeparator: ""},
                pageable: false,
                editable:true,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
                //Add row method
                columns: [
{ text:  '   '+document.getElementById("mainrentaltype").value, datafield: 'rentaltype', editable:false,cellclassname:'column2', cellbeginedit: rowEdit},
{ text: '      '+document.getElementById("mainrate").value,  datafield: 'rate', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},
{ text: '     '+document.getElementById("maincdw").value,  datafield: 'cdw',  editable:true ,renderer: columnsrenderer,cellsformat: 'd2' , cellsalign: 'right', align: 'right',cellclassname:'column2', cellbeginedit: rowEdit},
{ text: '     '+document.getElementById("mainpai").value,  datafield: 'pai',editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},
{ text: ''+document.getElementById("maincdw1").value,  datafield: 'cdw1', editable:true ,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},

{ text: ''+document.getElementById("mainpai1").value,  datafield: 'pai1',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},
 { text: '     '+document.getElementById("maingps").value,  datafield: 'gps', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},
{ text: ''+document.getElementById("mainbabyseater").value,  datafield: 'babyseater',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},
{ text: '    '+document.getElementById("maincooler").value,  datafield: 'cooler', editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit}, 
{ text: ''+document.getElementById("mainexkmrte").value,  datafield: 'exkmrte',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},
{ text: ''+document.getElementById("mainexhrchg").value,  datafield: 'exhrchg',  hidden:true,editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},
{ text: ''+document.getElementById("mainchaufchg").value,  datafield: 'chaufchg',  editable:true,renderer: columnsrenderer,cellsformat: 'd2',cellclassname:'column2', cellsalign: 'right', cellbeginedit: rowEdit},
{ text: 'Excesskm',  datafield: 'excesskm',hidden:true},
{ text: 'TermAmt',  datafield: 'termamt',hidden:true},
{ text: 'Term Month',  datafield: 'termmonth',hidden:true}
	              ]
            });


            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subrentaltype").value);
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
            $('#totalgrid').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
           
            if(document.getElementById("agreementno").value==''){
            $("#totalgrid").jqxGrid("addrow", null, {});
            }
  var rows= $("#totalgrid").jqxGrid("getrows");
  if(rows.length==0){
      $("#totalgrid").jqxGrid("addrow", null, {});
  }
           
            $("#totalgrid").on('cellendedit', function (event) 
 				   {
 			   var rowBoundIndex = event.args.rowindex;
 			   var dataField = event.args.datafield;
 			  //alert(""+rowBoundIndex)
 			
 			  if(rowBoundIndex==1)
 				   {
 						   var value = event.args.value;
 						   var temp = $('#totalgrid').jqxGrid('getcellvalue', 0, dataField);
 						   if((value=="")||(value=='undefined')||(value==null))
 							   {
 							   $("#totalgrid").jqxGrid('setcellvalue', 2, dataField, temp);
 							   }
 						   if(!((value=='')||(value=='undefined')||(value==null)))
 							   {
 						   var temp2=parseFloat(temp)-parseFloat(value);
 			               $("#totalgrid").jqxGrid('setcellvalue', 2, dataField, temp2);
 							   }
 						   }
 				   });			       

        });
        
            </script>
            <div id="totalgrid"></div>