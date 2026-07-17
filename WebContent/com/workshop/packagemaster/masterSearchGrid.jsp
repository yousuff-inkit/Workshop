<%@page import="com.workshop.packagemaster.*" %>
<%
ClsWSPackageMasterDAO gatedao=new ClsWSPackageMasterDAO();
String brand=request.getParameter("brand")==null?"":request.getParameter("brand");
String packagename=request.getParameter("packagename")==null?"":request.getParameter("packagename");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
String model=request.getParameter("model")==null?"":request.getParameter("model");
%>
<%-- <jsp:include page="../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
var searchdata=[];
var id='<%=id%>';
if(id=="1"){
	searchdata='<%=gatedao.getMasterSearch(brand,packagename,docno,date,id,brhid,model)%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'doc_no', type: 'number'   },
				{name : 'brdid', type: 'number'  },
				{name : 'modelid', type: 'number'   },
				{name : 'brand',type:'string'},
				{name : 'date',type:'date'},
				{name : 'model',type:'string'},
				{name : 'packagename',type:'string'},
				{name : 'fromdate',type:'date'},
				{name : 'todate',type:'date'},
				{name : 'amount',type:'number'},
				{name : 'maxusage',type:'number'},
				{name : 'description',type:'string'}
				
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
                            { text:'Doc No',datafield:'doc_no',width:'10%'},
                            { text:'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
                            { text:'Package Name',datafield:'packagename',width:'30%'},
                            { text:'From Date',datafield:'fromdate',width:'15%',hidden:true,cellsformat:'dd.MM.yyyy'},
                            { text:'To Date',datafield:'todate',width:'15%',hidden:true,cellsformat:'dd.MM.yyyy'},
							{ text:'Brand Id', datafield: 'brdid', width: '10%' ,hidden:true},			
							{ text: 'Model Id',datafield:'modelid',width:'47%',hidden:true},
							{ text: 'Brand',datafield:'brand',width:'20%'},
							{ text : 'Model', datafield:'model',width:'22%'},
							{ text : 'Amount', datafield:'amount',width:'40%',hidden:true,cellsformat:'d2'},
							{ text : 'Max Usage', datafield:'maxusage',width:'50%',cellsformat:'d0',hidden:true},
							{ text : 'Description', datafield:'description',width:'50%',hidden:true},
							
			              ]
            });
            
            $("#masterSearchGrid").on("rowdoubleclick", function (event) {
            	
                var row1=event.args.rowindex;
                $('#docno').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
                $('#packagename').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'packagename'));
                $('#cmbbrand').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'brdid'));
                $('#hidcmbmodel').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'modelid'));
                getModel($('#cmbbrand').val());
                $('#date').jqxDateTimeInput('val',$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'date'));
                $('#fromdate').jqxDateTimeInput('val',$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'fromdate'));
                $('#todate').jqxDateTimeInput('val',$('#masterSearchGrid').jqxGrid('getcellvalue',row1,'todate'));
                $('#amount').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'amount'));
                $('#maxusage').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'maxusage'));
                $('#description').val($('#masterSearchGrid').jqxGrid('getcellvalue',row1,'description'));
                $('#sparediv').load('sparePartsNewGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	$('#labourdiv').load('labourcostGrid.jsp?docno='+$('#docno').val()+'&id=1');
               	$('#jobtypeinputdiv').load('jobtypeinput.jsp?id=1');
               	$('#window').jqxWindow('close');
				
                });
        });
    </script>
    <div id="masterSearchGrid"></div>
    