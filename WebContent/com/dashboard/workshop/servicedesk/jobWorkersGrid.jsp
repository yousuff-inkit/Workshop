<%@page import="com.dashboard.workshop.servicedesk.*" %>
<%ClsWSServiceDeskDAO floordao=new ClsWSServiceDeskDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
String jobcarddocno=request.getParameter("jobcarddocno")==null?"":request.getParameter("jobcarddocno");
%>

<script type="text/javascript">
var id='<%=id%>';
var jobworkersdata=[];
if(id=="1"){
	jobworkersdata='<%=floordao.getJobWorkersData(id,jobcarddocno)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'technician' , type: 'string'},
                      	{name : 'workhours',type:'number'},
 						{name : 'startdate', type: 'date'},
 						{name : 'closedate', type: 'date'},
 						{name : 'starttime', type: 'string'},
                      	{name : 'closetime', type: 'string'},
                      	
             ],
             localdata: jobworkersdata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        var rendererstring=function (aggregates) {
         	var value=aggregates['sum'];
         	if(value=="undefined" || value==null || value=="" || typeof(value)=="undefined"){
         		value="0.0";
         	}
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
        }
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#jobWorkersGrid").jqxGrid(
                {
                	width: '100%',
                    height: 300,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    showstatusbar:true,
                    showaggregates:true,
                     columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%',cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Technician',datafield: 'technician', width: '30%'},
    					{ text: 'Work Hours',datafield: 'workhours',width:'10%',cellsformat:'d2',aggregates:['sum'],aggregatesrenderer:rendererstring,filtertype:'number'},
    					{ text: 'Start Date',datafield: 'startdate', width: '15%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'Start Time',datafield: 'starttime', width: '10%'},
    					{ text: 'Close Date',datafield: 'closedate', width: '15%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Close Time',datafield: 'closetime', width: '10%'},
    	              ]
                });

	});
</script>
<div id="jobWorkersGrid"></div>