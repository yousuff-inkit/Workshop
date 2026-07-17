<%@page import="com.workshop.estimationadditionv5.*" %>
<%
ClsEstimationAdditionV5DAO gatedao=new ClsEstimationAdditionV5DAO();
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<script type="text/javascript">
var gatedata;
var id='<%=id%>';
if(id=="1"){
	gatedata='<%=gatedao.getGateInPassData(gatedocno,cldocno,clientname,jobdocno,date,id,brhid)%>';
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
				{name : 'gatedocno',type:'number'},
				{name : 'gatevocno',type:'number'},
				{name : 'estdocno',type:'number'},
				{name : 'regno',type:'number'},
				{name : 'date',type:'date'},
				{name : 'vehicledetails',type:'string'},
				{name : 'refname',type:'string'},
				{name : 'cldocno',type:'number'},
				{name : 'userdetails',type:'string'},
				{name : 'addition',type:'number'},
				{name : 'gipdatetime',type:'string'},
				{name : 'gipinsurcomp',type:'string'},
				{name : 'gipclaimno',type:'string'},
				{name : 'serviceadvisor',type:'string'},
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
                width: '100%',
                height: 300,
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
                            { text: 'Gate Docno',datafield:'gatedocno',width:'10%',hidden:true},
                            { text: 'GIP No',datafield:'gatevocno',width:'10%'},
                            { text: 'Est Docno',datafield:'estdocno',width:'10%',hidden:true},
							{ text:'Reg No', datafield: 'regno', width: '10%' },			
							{ text:'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'User Details',datafield:'userdetails',width:'47%',hidden:true},
							{ text: 'Vehicle Details',datafield:'vehicledetails',width:'47%',hidden:true},
							{ text : 'Client Doc No', datafield:'cldocno',width:'12%'},
							{ text : 'Client', datafield:'refname',width:'40%'},
							{ text : 'Addition', datafield:'addition',width:'50%',hidden:true},
							{ text : 'GIP Date Time', datafield:'gipdatetime',width:'50%',hidden:true},
							{ text : 'GIP Insur Company', datafield:'gipinsurcomp',width:'50%',hidden:true},
							{ text : 'GIP Claim No', datafield:'gipclaimno',width:'50%',hidden:true},
							{ text : 'Service Advisor', datafield:'serviceadvisor',width:'50%',hidden:true}
			              ]
            });
            
            $("#gateInPassSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                $('#jobcarddocno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
                $('#jobcardvocno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'voc_no'));
                $('#estdocno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'estdocno'));
                $('#gatedocno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gatedocno'));
                $('#gatevocno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gatevocno'));
                $('#gateuserdetails').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'userdetails'));
                $('#gatevehicledetails').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'vehicledetails'));
                $('#addition').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'addition'));
                $('#gipdatetime').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gipdatetime'));
                $('#gipinsurcomp').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gipinsurcomp'));
                $('#gipclaimno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gipclaimno'));
               	$('#gipclaimno').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'gipclaimno'));
               	$('#cmbserviceadvisor').val(null).trigger('change');
               	$('#cmbserviceadvisor').val($('#gateInPassSearchGrid').jqxGrid('getcellvalue',row1,'serviceadvisor')).trigger('change');
                $('#complaintdiv').load('complaintGrid.jsp?docno='+$('#gatedocno').val()+'&id=1');
				$('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
				funChangeEntity();
				$('#searchwindow').jqxWindow('close');
                });
        });
    </script>
    <div id="gateInPassSearchGrid"></div>
    