<%@page import="com.workshop.packagemasterv2.*" %>
<%
ClsWSPackageMasterV2DAO gatedao=new ClsWSPackageMasterV2DAO();
String jobdocno=request.getParameter("jobdocno")==null?"":request.getParameter("jobdocno");
String jobtype=request.getParameter("jobtype")==null?"":request.getParameter("jobtype");
String jobtypename=request.getParameter("jobtypename")==null?"":request.getParameter("jobtypename");
String date=request.getParameter("date")==null?"":request.getParameter("date");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String labourindex=request.getParameter("labourindex")==null?"":request.getParameter("labourindex");
String gatedocno=request.getParameter("gatedocno")==null?"":request.getParameter("gatedocno");
%>
<script type="text/javascript">
var laboursearchdata=[];
var labourindex='<%=labourindex%>';
var id='<%=id%>';
if(id=="1"){
	laboursearchdata='<%=gatedao.getLabourSearchData(jobdocno,jobtype,date,id,gatedocno,jobtypename)%>';
}
$(document).ready(function () { 

     var source =
     {
         datatype: "json",
         datafields: [
				{name : 'doc_no', type: 'number'   },
				{name : 'date',type:'date'},
				{name : 'hrs',type:'number'},
				{name : 'rate',type:'number'},
				{name : 'jobtype',type:'string'},
				{name : 'jobtypeid',type:'string'},
				{name : 'jobdesc',type:'string'},
				{name : 'taxable',type:'string'},
          ],
          localdata: laboursearchdata,
         
         
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


            
            
            $("#labourSearchGrid").jqxGrid(
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
                            { text:'Doc No',datafield:'doc_no',width:'8%'},
							{ text:'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true},
							{ text:'Job Type',datafield:'jobtype',width:'15%'},
							{ text:'Job Desc', datafield:'jobdesc',width:'45%'},
							{ text:'Job Type Id',datafield:'jobtypeid',width:'1%',hidden:true},
							{ text:'Taxable',datafield:'taxable',width:'1%',hidden:true},
							{ text:'Hours', datafield:'hrs',width:'12%',cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text:'Rate', datafield:'rate',width:'12%',cellsformat:'d2',cellsalign:'right',align:'right'},
							
			              ]
            });
            
            $("#labourSearchGrid").on("rowdoubleclick", function (event) {
                var row1=event.args.rowindex;
                $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobtype',$('#labourSearchGrid').jqxGrid('getcellvalue',row1,'jobtype'));
                $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobdesc',$('#labourSearchGrid').jqxGrid('getcellvalue',row1,'jobdesc'));
                $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'jobid',$('#labourSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
                $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'hrs',$('#labourSearchGrid').jqxGrid('getcellvalue',row1,'hrs'));
                $('#labourcostGrid').jqxGrid('setcellvalue',labourindex,'seqno',labourindex);
                $("#labourcostGrid").jqxGrid("addrow", null, {});
                $('#laboursearchwindow').jqxWindow('close'); 
                
            });
        });
    </script>
     <div id="labourSearchGrid"></div>
