<%@page import="com.workshop.estimationadditionv4.*" %>
<%
ClsEstimationAdditionV4DAO gatedao=new ClsEstimationAdditionV4DAO();
String gatevocno=request.getParameter("gatevocno")==null?"":request.getParameter("gatevocno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
%>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var searchdata=[];
var id='<%=id%>';
if(id=="1"){
	searchdata='<%=gatedao.getMasterSearch(gatevocno,cldocno,clientname,docno,date,id,branch,regno)%>';
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
				{name : 'jobdocno', type: 'number'  },
				{name : 'jobvocno', type: 'number'   },
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
				{name : 'addition',type:'number'},
				{name : 'chkservicelumsum',type:'string'},
				{name : 'servicelumsumamt',type:'string'},
				{name : 'chkrandomlumsum',type:'string'},
				{name : 'randomlumsumamt',type:'string'},
				{name : 'header',type:'string'},
				{name : 'notes',type:'string'},
				{name : 'internalremarks',type:'string'},
				{name : 'estimatedays',type:'string'},
				{name : 'gipdatetime',type:'string'},
				{name : 'gipinsurcomp',type:'string'},
				{name : 'gipclaimno',type:'string'},
				{name : 'serviceadvisor',type:'string'},
				{name : 'sparetotal',type:'number'},
				{name : 'sparediscount',type:'number'},
				{name : 'netspare',type:'number'},
				{name : 'entitytype',type:'number'},
				{name : 'distservicediscount',type:'number'},
				{name : 'distsparediscount',type:'number'}
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
                            { text:'Doc No',datafield:'voc_no',width:'8%'},
                            { text : 'Add#', datafield:'addition',width:'6%',cellsformat:'d0',hidden:false},
                            { text:'Doc No Original',datafield:'doc_no',width:'15%',hidden:true},
                            { text:'GIP #',datafield:'gatevocno',width:'8%'},
                            { text:'Gate Doc No Original',datafield:'gatedocno',width:'15%',hidden:true},
                            { text:'Job Doc No',datafield:'jobvocno',width:'10%',hidden:true},
                            { text:'Job Doc No Original',datafield:'jobdocno',width:'15%',hidden:true},
							{ text:'Reg No', datafield: 'regno', width: '10%' },			
							{ text:'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User Details',datafield:'userdetails',width:'47%',hidden:true},
							{ text: 'Vehicle Details',datafield:'vehicledetails',width:'47%',hidden:true},
							{ text : 'Client #', datafield:'cldocno',width:'10%'},
							{ text : 'Client', datafield:'refname',width:'40%'},
							{ text : 'Services Total', datafield:'servicestotal',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Services Discount', datafield:'servicesdiscount',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Net Total', datafield:'netservices',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Lump Sum Checkbox', datafield:'chklumsum',width:'50%',hidden:true},
							{ text : 'Lump Sum Amount', datafield:'lumsumamount',width:'50%',cellsformat:'d2',hidden:true},
							
							{ text : 'Service Lump Sum Checkbox', datafield:'chkservicelumsum',width:'50%',hidden:true},
							{ text : 'Service Lump Sum Amount', datafield:'servicelumsumamt',width:'50%',cellsformat:'d2',hidden:true},
			              	{ text : 'Random Lump Sum Checkbox', datafield:'chkrandomlumsum',width:'50%',hidden:true},
							{ text : 'Random Lump Sum Amount', datafield:'randomlumsumamt',width:'50%',cellsformat:'d2',hidden:true},
							{ text: 'Header Details',datafield:'header',width:'47%',hidden:true},
			              	{ text: 'Notes Details',datafield:'notes',width:'47%',hidden:true},
			              	{ text: 'Internal Remarks Details',datafield:'internalremarks',width:'47%',hidden:true},
			              	{ text: 'Estimate Days',datafield:'estimatedays',width:'10%',hidden:true},
							{ text: 'GIP Date Time',datafield:'gipdatetime',width:'10%',hidden:true},
							{ text: 'GIP Insur Comp',datafield:'gipinsurcomp',width:'10%',hidden:true},
							{ text: 'GIP Claim No',datafield:'gipclaimno',width:'10%',hidden:true},
							{ text: 'Service Advisor',datafield:'serviceadvisor',width:'10%',hidden:true},
							{ text : 'Spare Total', datafield:'sparetotal',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Spare Discount', datafield:'sparediscount',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Net Spare', datafield:'netspare',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Entity Type', datafield:'entitytype',width:'50%',hidden:true},
							{ text : 'Dist.Service Discount', datafield:'distservicediscount',width:'50%',hidden:true},
							{ text : 'Dist.Spare Discount', datafield:'distsparediscount',width:'50%',hidden:true},
							
			              ]
            });
            
            $("#masterSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                $('#gatedocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gatedocno'));
                $('#gatevocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gatevocno'));
                $('#date').jqxDateTimeInput('val',$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'date'));
                $('#docno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
                $('#estdocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
                $('#vocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'voc_no'));
                $('#jobcarddocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'jobdocno'));
                $('#jobcardvocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'jobvocno'));
                $('#gateuserdetails').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'userdetails'));
                $('#gatevehicledetails').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'vehicledetails'));
                $('#servicestotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'servicestotal'));
                $('#servicesdiscount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'servicesdiscount'));
                $('#netservices').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'netservices'));
                $('#addition').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'addition'));
                
                $('#distservicediscount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'distservicediscount'));
                $('#distsparediscount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'distsparediscount'));
                
                $('#complaintdiv').load('complaintGrid.jsp?docno='+$('#gatedocno').val()+'&id=1');
               	$('#sparepartsdiv').load('sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1&addition='+$('#addition').val());
               	$('#labourcostdiv').load('labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1&addition='+$('#addition').val());
               	$('#sparepartsamountdiv').load('sparePartsAmountGrid.jsp?gatedocno='+$('#gatedocno').val()+'&id=1&addition='+$('#addition').val());
               	$('#lumsumamount,#servicelumsumamt,#randomlumsumamt').val('');
               	$('#cmbserviceadvisor').val(null).trigger('change');
               	$('#header').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'header'));
                $('#notes').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'notes'));
                $('#internalremarks').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'internalremarks'));
                $('#estimatedays').val($('#masterSearchGrid').jqxGrid('getcellvalue', row1, "estimatedays"));
                $('#gipinsurcomp').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gipinsurcomp'));
                $('#gipclaimno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gipclaimno'));
                $('#gipdatetime').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gipdatetime'));
                $('#cmbserviceadvisor').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'serviceadvisor')).trigger('change');
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
               	$('#cmbentitytype').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'entitytype'));
               	
               	
               	funDtype();
    			getapprcount();
    			apprCheck(); 
               	
               	setLumSum();
               	setServiceLumSum();
               	setRandomLumSum();
               	$('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
               	CheckEditStatus($('#docno').val());
               	
				$('#window').jqxWindow('close');
                });
        });
    </script>
    <div id="masterSearchGrid"></div>
    