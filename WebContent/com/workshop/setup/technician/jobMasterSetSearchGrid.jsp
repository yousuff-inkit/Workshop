<%@page import="com.workshop.setup.jobmaster.ClsJobMasterDAO" %>
<%ClsJobMasterDAO dao=new ClsJobMasterDAO();
String check=request.getParameter("id")==null?"0":request.getParameter("id");
%>

<script type="text/javascript">
var check='<%=check%>';
var jobsrchdata;
if(check=="1"){
	jobsrchdata='<%=dao.loadgrid()%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [ 
                      	{name : 'desc' , type: 'string' },
                      	{name : 'doc_no' , type: 'string' },
                      	{name : 'date' , type: 'string' },
                      	{name : 'type' , type: 'string' },
                      	{name : 'jobid' , type: 'string' },
             ],
             localdata: jobsrchdata,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#jobSearchGrid").jqxGrid(
                {
                	width: '100%',
                    height: 350,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  //  pagermode: 'default',
                    sortable: true,
                    //pageable: true,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },  
						{ text: 'Doc_no',datafield: 'doc_no', width: '5%' ,hidden:true},
						{ text: 'Date',datafield: 'date', width: '12%' },
						{ text: 'JobType',datafield: 'type', width: '12%' },
    					{ text: 'Description',datafield: 'desc', width: '70%' },
    					{ text: 'JobTypeid',datafield: 'jobid', width: '5%',hidden:true },

    	              ]
                });
          
        $("#jobSearchGrid").on("rowdoubleclick", function (event) {
            var row1=event.args.rowindex;
            var rowindex1 =$('#jobmasterRowindex').val();
			$('#jobMasterGrid').jqxGrid('setcellvalue', rowindex1, "jobtypeid",$('#jobSearchGrid').jqxGrid('getcellvalue',row1,'doc_no'));
			$('#jobMasterGrid').jqxGrid('setcellvalue', rowindex1, "jobtype",$('#jobSearchGrid').jqxGrid('getcellvalue',row1,'type'));
			$('#jobMasterGrid').jqxGrid('setcellvalue', rowindex1, "jobdesc",$('#jobSearchGrid').jqxGrid('getcellvalue',row1,'desc'));
			
			 
			 var rows = $('#jobMasterGrid').jqxGrid('getrows');
             var rowlength= rows.length;
             var rowindex2 = rowlength - 1;
        	 var jobid=$("#jobMasterGrid").jqxGrid('getcellvalue', rowindex2, "jobtypeid");
        	 if(typeof(jobid) != "undefined" && jobid != ""){
        		/* $("#jobMasterGrid").jqxGrid('addrow', null, {"account": "","accountname": "","doc_no": ""}); */
        		 $("#jobMasterGrid").jqxGrid("addrow", null, {});
        	 }
			
			
			
			 
			$('#jobmasterWindow').jqxWindow('hide');
			 
			 
            });
        
        

	});
</script>
<div id="jobSearchGrid"></div>