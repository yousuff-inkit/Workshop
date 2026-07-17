<%@page import="com.workshop.setup.technician.ClsTechnicianDAO" %>
<%ClsTechnicianDAO dao=new ClsTechnicianDAO();
String check=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
System.out.println("check="+check);
%>
<script type="text/javascript">
var check='<%=check%>';
var jobmasterdata;
if(check=="1"){
	jobmasterdata='<%=dao.loadJobmasteGrid(docno,check)%>';
}
	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [ 
                      	{name : 'jobtype' , type: 'string' },
                      	{name : 'jobtypeid',type:'string'},
                      	{name : 'jobdesc',type:'string'}
             ],
             localdata: jobmasterdata,
            
            
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



        $("#jobMasterGrid").jqxGrid(
                {
                	width: '100%',
                    height: 350,
                    source: dataAdapter,
                    selectionmode: 'singlerow',
                  //  pagermode: 'default',
                    sortable: true,
                    //pageable: true,
                    altrows:true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '10%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Job Type',datafield: 'jobtype', width: '20%' },
    					{ text: 'Job Type ID',datafield: 'jobtypeid', width: '10%',hidden: true },
    					{ text: 'Job Type Description',datafield: 'jobdesc', width: '70%' }
    					
    					
    	              ]
                });
       
        var rows = $('#jobMasterGrid').jqxGrid('getrows');
        var rowlength= rows.length;
        var rowindex2 = rowlength - 1;
   	 var jobid=$("#jobMasterGrid").jqxGrid('getcellvalue', rowindex2, "jobtypeid");
   	 if(typeof(jobid) != "undefined" && jobid != ""){
   		/* $("#jobMasterGrid").jqxGrid('addrow', null, {"account": "","accountname": "","doc_no": ""}); */
   		 $("#jobMasterGrid").jqxGrid("addrow", null, {});
   	 }
		
        
        $("#jobMasterGrid").on("rowdoubleclick", function (event) {
           var rowindex1=event.args.rowindex;
			document.getElementById("jobmasterRowindex").value = rowindex1;
			jobmasterSearchContent('jobMasterSetSearchGrid.jsp?id=1');
			
			
        });	

	});
</script>
<div id="jobMasterGrid"></div>
<input type="hidden" id="jobmasterRowindex" name="jobmasterRowindex"/>