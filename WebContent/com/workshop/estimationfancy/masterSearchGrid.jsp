<%@page import="com.workshop.wsestimationfancy.*" %>
<%
ClsWSEstimationFancyDAO gatedao=new ClsWSEstimationFancyDAO();
String gatevocno=request.getParameter("gatevocno")==null?"":request.getParameter("gatevocno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String reg=request.getParameter("regno")==null?"":request.getParameter("regno");
%>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var searchdata;
var id='<%=id%>';
if(id=="1"){
	searchdata='<%=gatedao.getMasterSearch(gatevocno,cldocno,clientname,docno,date,id,reg)%>';
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
				{name : 'sparemarkup',type:'number'},
				{name : 'labdiscount',type:'number'},
				{name : 'sparetotal',type:'number'},
				{name : 'sparediscount',type:'number'},
				{name : 'sparenettotal',type:'number'},
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
                height: 300,
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
                            { text:'Gate Doc No',datafield:'gatevocno',width:'10%'},
                            { text:'Gate Doc No Original',datafield:'gatedocno',width:'15%',hidden:true},
							{ text:'Reg No', datafield: 'regno', width: '10%' },			
							{ text:'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User Details',datafield:'userdetails',width:'47%',hidden:true},
							{ text: 'Vehicle Details',datafield:'vehicledetails',width:'47%',hidden:true},
							{ text : 'Client Doc No', datafield:'cldocno',width:'12%'},
							{ text : 'Client', datafield:'refname',width:'40%'},
							{ text : 'Services Total', datafield:'servicestotal',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Services Discount', datafield:'servicesdiscount',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Net Total', datafield:'netservices',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Lump Sum Checkbox', datafield:'chklumsum',width:'50%',hidden:true},
							{ text : 'Lump Sum Amount', datafield:'lumsumamount',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Spare Markup', datafield:'sparemarkup',width:'50%',hidden:true,cellsformat:'d2'},
							{ text : 'Labour Discount', datafield:'labdiscount',width:'50%',hidden:true,cellsformat:'d2'},
							{ text : 'Spare Total', datafield:'sparetotal',width:'50%',hidden:true,cellsformat:'d2'},
							{ text : 'Spare Discount', datafield:'sparediscount',width:'50%',hidden:true,cellsformat:'d2'},
							{ text : 'Spare Net Total', datafield:'sparenettotal',width:'50%',hidden:true,cellsformat:'d2'},
			              ]
            });
            
            $("#masterSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                $('#gatedocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gatedocno'));
                $('#gatevocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'gatevocno'));
                $('#docno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
                $('#vocno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'voc_no'));
                $('#gateuserdetails').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'userdetails'));
                $('#gatevehicledetails').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'vehicledetails'));
                $('#servicestotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'servicestotal'));
                $('#servicesdiscount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'servicesdiscount'));
                $('#netservices').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'netservices'));
                $('#sparemarkup').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'sparemarkup'));
                $('#labdiscount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'labdiscount'));
                $('#complaintdiv').load('complaintGrid.jsp?docno='+$('#gatedocno').val()+'&id=1');
               	$('#sparepartsdiv').load('sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	$('#labourcostdiv').load('labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	$('#sparepartsamountdiv').load('sparePartsAmountGrid.jsp?gatedocno='+$('#gatedocno').val()+'&id=1');
               	var chklumsum=$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'chklumsum');
               	$('#sparetotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'sparetotal'));
               	$('#sparediscount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'sparediscount'));
               	$('#sparenettotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'sparenettotal'));
               	
               	if(chklumsum=="1"){
               		document.getElementById("hidchklumsum").value="1";
               		document.getElementById("chklumsum").checked=true;
               	}
               	else{
               		document.getElementById("hidchklumsum").value="0";
               		document.getElementById("chklumsum").checked=false;
               	}
               	$('#lumsumamount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'lumsumamount'));
               	setLumSum();
               	CheckEditStatus($('#docno').val());
				$('#window').jqxWindow('close');
                });
        });
    </script>
    <div id="masterSearchGrid"></div>
    