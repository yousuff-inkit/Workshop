<%@page import="com.workshop.wsestimation.*" %>
<%
ClsWSEstimationDAO gatedao=new ClsWSEstimationDAO();
String gatevocno=request.getParameter("gatevocno")==null?"":request.getParameter("gatevocno");
String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno");
String clientname=request.getParameter("clientname")==null?"":request.getParameter("clientname");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var searchdata;
var id='<%=id%>';
if(id=="1"){
	searchdata='<%=gatedao.getMasterSearch(gatevocno,cldocno,clientname,docno,date,id)%>';
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
				{name : 'sparepartstotal',type:'number'},
				{name : 'labourcosttotal',type:'number'},
				{name : 'discount',type:'number'},
				{name : 'nettotal',type:'number'}
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
							{ text : 'Spare Parts Total', datafield:'sparepartstotal',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Labour Cost Total', datafield:'labourcosttotal',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Discount', datafield:'discount',width:'50%',cellsformat:'d2',hidden:true},
							{ text : 'Net Total', datafield:'nettotal',width:'50%',cellsformat:'d2',hidden:true}
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
                $('#sparepartstotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'sparepartstotal'));
                $('#labourtotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'labourcosttotal'));
                $('#discount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'discount'));
                $('#esttotal').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'nettotal'));
                $('#complaintdiv').load('complaintGrid.jsp?docno='+$('#gatedocno').val()+'&id=1');
               	$('#sparepartsdiv').load('sparepartsGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	$('#labourcostdiv').load('labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	CheckEditStatus($('#docno').val());
				$('#window').jqxWindow('close');
                });
        });
    </script>
    <div id="masterSearchGrid"></div>
    