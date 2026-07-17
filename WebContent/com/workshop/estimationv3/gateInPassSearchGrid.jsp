<%@page import="com.workshop.estimationv3.*" %>
<%
ClsEstimationV3DAO gatedao=new ClsEstimationV3DAO();
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String regno=request.getParameter("regno")==null?"":request.getParameter("regno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<script type="text/javascript">
var gatedata=[];
var id='<%=id%>';
if(id=="1"){
	gatedata='<%=gatedao.getGateInPassData(gatedocno,cldocno,clientname,regno,date,id,brhid)%>';
	
}
else{
	gatedata=[];
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'voc_no', type: 'number'  },
				{name : 'doc_no', type: 'number'   },
				{name : 'regno',type:'number'},
				{name : 'date',type:'date'},
				{name : 'vehicledetails',type:'string'},
				{name : 'refname',type:'string'},
				{name : 'cldocno',type:'number'},
				{name : 'userdetails',type:'string'},
				{name : 'gipdatetime',type:'string'},
				{name : 'gipinsurcomp',type:'string'},
				{name : 'gipclaimno',type:'string'},
				{name : 'rateconfig',type:'number'},
				{name : 'wsserviceamt',type:'number'}
          ],
          localdata: gatedata,
         
         
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


            
            
            $("#gateInPassSearchGrid").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                
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
							{ text:'Reg No', datafield: 'regno', width: '10%' },			
							{ text:'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User Details',datafield:'userdetails',width:'47%',hidden:true},
							{ text: 'Vehicle Details',datafield:'vehicledetails',width:'47%',hidden:true},
							{ text : 'Client Doc No', datafield:'cldocno',width:'12%'},
							{ text : 'Client', datafield:'refname',width:'50%'},
							{ text : 'GIP Date Time', datafield:'gipdatetime',width:'10%',hidden:true},
							{ text : 'GIP Insur Company', datafield:'gipinsurcomp',width:'10%',hidden:true},
							{ text : 'Rate Config', datafield:'rateconfig',width:'10%',hidden:true},
							{ text : 'WS Service Amount', datafield:'wsserviceamt',width:'10%',hidden:true},
							{ text : 'GIP Claim No', datafield:'gipclaimno',width:'10%',hidden:true}
			              ]
            });
            
            $("#gateInPassSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                $('#gatedocno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
                $('#gatevocno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'voc_no'));
                $('#gateuserdetails').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'userdetails'));
                $('#gatevehicledetails').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'vehicledetails'));
                $('#gipdatetime').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gipdatetime'));
                $('#gipinsurcomp').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gipinsurcomp'));
                $('#gipclaimno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gipclaimno'));
               	$('#rateconfig').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'rateconfig'));
               	$('#wsserviceamt').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'wsserviceamt'));
               	
               	$('#complaintdiv').load('complaintGrid.jsp?docno='+$('#gatedocno').val()+'&id=1');
				$('#searchwindow').jqxWindow('close');
                $('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
                funChangeEntity();
                });
        });
    </script>
    <div id="gateInPassSearchGrid"></div>
    