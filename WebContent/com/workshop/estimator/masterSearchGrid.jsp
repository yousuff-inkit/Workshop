<%@page import="com.workshop.estimator.*" %>
<%
ClsEstimationDAO gatedao=new ClsEstimationDAO();
String gatevocno=request.getParameter("gatevocno")==null?"":request.getParameter("gatevocno");
String cldet=request.getParameter("cldet")==null?"":request.getParameter("cldet");
String vehdet=request.getParameter("vehdet")==null?"":request.getParameter("vehdet");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
%>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var searchdata;
var id='<%=id%>';
if(id=="1"){
	searchdata='<%=gatedao.getMasterSearch(gatevocno,cldet,vehdet,docno,date,id,brhid,regno)%>';
}
else{
	searchdata=[];
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'voc_no', type: 'number'  },
				{name : 'doc_no', type: 'number'   },
				{name : 'gatedocno', type: 'number'  },
				{name : 'gatevocno', type: 'number'   },
				{name : 'regno',type:'number'},
				{name : 'date',type:'date'},
				{name : 'vehicledetails',type:'string'},
				{name : 'refname',type:'string'},
				{name : 'cldocno',type:'number'},
				{name : 'userdetails',type:'string'},
				{name : 'servicestotal',type:'number'},
				{name : 'servicesdiscount',type:'number'},
				{name : 'netservices',type:'number'},
				{name : 'chklumsum',type:'string'},
				{name : 'lumsumamount',type:'string'},
				{name : 'header',type:'string'},
				{name : 'notes',type:'string'},
				{name : 'internalremarks',type:'string'},
				{name : 'chkservicelumsum',type:'string'},
				{name : 'servicelumsumamt',type:'string'},
				{name : 'chkrandomlumsum',type:'string'},
				{name : 'randomlumsumamt',type:'string'},
				{name : 'estimatedays',type:'string'},
				{name : 'gipdatetime',type:'string'},
				{name : 'gipinsurcomp',type:'string'},
				{name : 'gipclaimno',type:'string'},
				{name : 'sparetotal',type:'number'},
				{name : 'sparediscount',type:'number'},
				{name : 'netspare',type:'number'},
				{name : 'clientdet',type:'string'},
				{name : 'vehicledet',type:'string'},
				{name : 'description',type:'string'},
				
          ],
          localdata: searchdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
    			loadComplete: function () {
            		 $("#loadingImage").css("display", "none"); 
        		},
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	            
            }		
    );


            
            
            $("#masterSearchGrid").jqxGrid(
            {
                width: '99%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                localization: {thousandsSeparator: ""},
                //Add row method
                handlekeyboardnavigation: function (event) {
                    /* var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                    
                },
                
                       
                columns: [
							{ text: 'Sr. No.',datafield: '',columntype:'number', width: '8%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },	
                            { text:'Doc No',datafield:'voc_no',width:'10%'},
                            { text:'Doc No Original',datafield:'doc_no',width:'15%',hidden:true},
                            { text:'Gate Doc No',datafield:'gatevocno',width:'10%',hidden:true},
                            { text:'Gate Doc No Original',datafield:'gatedocno',width:'15%',hidden:true},
							{ text:'Reg No', datafield: 'regno', width: '10%' ,hidden:true},			
							{ text:'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Client Details',datafield:'clientdet',width:'36%'},
							{ text: 'Vehicle Details',datafield:'vehicledet',width:'36%'},
							{ text: 'User Details',datafield:'userdetails',width:'47%',hidden:true},
							{ text: 'Vehicle Details',datafield:'vehicledetails',width:'47%',hidden:true},
							{ text : 'Client Doc No', datafield:'cldocno',width:'12%',hidden:true},
							{ text : 'Client', datafield:'refname',width:'40%',hidden:true},
							{ text : 'Services Total', datafield:'servicestotal',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Services Discount', datafield:'servicesdiscount',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Net Total', datafield:'netservices',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Lum Sum Checkbox', datafield:'chklumsum',width:'50%',hidden:true},
							{ text : 'Lum Sum Amount', datafield:'lumsumamount',width:'50%',cellsformat:'d2',hidden:true},
			              	{ text: 'Header Details',datafield:'header',width:'47%',hidden:true},
			              	{ text: 'Notes Details',datafield:'notes',width:'47%',hidden:true},
			              	{ text: 'Internal Remarks Details',datafield:'internalremarks',width:'47%',hidden:true},
			              	{ text : 'Service Lump Sum Checkbox', datafield:'chkservicelumsum',width:'50%',hidden:true},
							{ text : 'Service Lump Sum Amount', datafield:'servicelumsumamt',width:'50%',cellsformat:'d2',hidden:true},
			              	{ text : 'Random Lump Sum Checkbox', datafield:'chkrandomlumsum',width:'50%',hidden:true},
							{ text : 'Random Lump Sum Amount', datafield:'randomlumsumamt',width:'50%',cellsformat:'d2',hidden:true},
							{ text: 'Estimate Days',datafield:'estimatedays',width:'10%',hidden:true},
							{ text: 'GIP Date Time',datafield:'gipdatetime',width:'10%',hidden:true},
							{ text: 'GIP Insur Comp',datafield:'gipinsurcomp',width:'10%',hidden:true},
							{ text: 'GIP Claim No',datafield:'gipclaimno',width:'10%',hidden:true},
							{ text : 'Spare Total', datafield:'sparetotal',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Spare Discount', datafield:'sparediscount',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Net Spare', datafield:'netspare',width:'50%',cellsformat:'d2',hidden:true},
							{ text: 'description',datafield:'description',width:'10%',hidden:true},
							
			              ]
            });
            
            $("#masterSearchGrid").on("rowdoubleclick", function (event) {
            	
                var row1=event.args.rowindex;
                $('#clientdet').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'clientdet'));
                $('#vehicledet').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'vehicledet'));
                $('#txtdesc').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'description'));
                $('#gatedocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gatedocno'));
                $('#gatevocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gatevocno'));
                $('#docno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
                $('#date').jqxDateTimeInput('val',$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'date'));
                $('#vocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'voc_no'));
                $('#gateuserdetails').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'userdetails'));
                $('#gatevehicledetails').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'vehicledetails'));
                $('#header').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'header'));
                $('#notes').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'notes'));
                $('#internalremarks').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'internalremarks'));
                $('#estimatedays').val($('#masterSearchGrid').jqxGrid('getcellvalue', row1, "estimatedays"));
                
                $('#servicestotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'servicestotal'));
                $('#servicesdiscount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'servicesdiscount'));
                $('#netservices').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'netservices'));
                
                $('#sparetotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'sparetotal'));
                $('#sparediscount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'sparediscount'));
                $('#netspare').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'netspare'));
                
                $('#gipinsurcomp').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gipinsurcomp'));
                $('#gipclaimno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gipclaimno'));
                
                $('#complaintdiv').load('complaintGrid.jsp?docno='+$('#gatedocno').val()+'&id=1');
               	$('#sparepartsdiv').load('sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	$('#labourcostdiv').load('labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	$('#sparepartsamountdiv').load('sparePartsAmountGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	$('#lumsumamount,#servicelumsumamt,#randomlumsumamt').val('');
               	var chklumsum=$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'chklumsum');
               	if(chklumsum=="1"){
               		document.getElementById("hidchklumsum").value="1";
               		document.getElementById("chklumsum").checked=true;
               		$('#lumsumamount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'lumsumamount'));
               	}
               	else{
               		document.getElementById("hidchklumsum").value="0";
               		document.getElementById("chklumsum").checked=false;
               	}
               	var chkservicelumsum=$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'chkservicelumsum');
               	if(chkservicelumsum=="1"){
               		document.getElementById("hidchkservicelumsum").value="1";
               		document.getElementById("chkservicelumsum").checked=true;
               		$('#servicelumsumamt').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'servicelumsumamt'));
               	}
               	else{
               		document.getElementById("hidchkservicelumsum").value="0";
               		document.getElementById("chkservicelumsum").checked=false;
               	}
               	var chkrandomlumsum=$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'chkrandomlumsum');
               	if(chkrandomlumsum=="1"){
               		document.getElementById("hidchkrandomlumsum").value="1";
               		document.getElementById("chkrandomlumsum").checked=true;
               		$('#randomlumsumamt').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'randomlumsumamt'));
               	}
               	else{
               		document.getElementById("hidchkrandomlumsum").value="0";
               		document.getElementById("chkrandomlumsum").checked=false;
               	}
               	$('#gipdatetime').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gipdatetime'));
               	setLumSum();
               	setServiceLumSum();
               	setRandomLumSum();
                $('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
               	CheckEditStatus($('#docno').val());
				getEstPrintConfig();
				if($('#docno').val()!='' && $('#mode').val()=='view'){
					document.getElementById("btnCalculate").disabled=false; 
			    } 
				$('#window').jqxWindow('close');
				
                });
        });
    </script>
    <div id="masterSearchGrid"></div>
    