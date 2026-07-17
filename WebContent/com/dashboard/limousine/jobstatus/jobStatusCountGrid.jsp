<%@page import="com.dashboard.limousine.jobstatus.*" %>
<%ClsLimoJobStatusDAO statusdao=new ClsLimoJobStatusDAO();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String status=request.getParameter("status")==null?"":request.getParameter("status");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var countdata;
var id='<%=id%>';
var status='<%=status%>';
var fromdate='<%=fromdate%>';
var todate='<%=todate%>';
var branch='<%=branch%>';
if(id=="1"){
	countdata='<%=statusdao.getCountData(fromdate,todate,status,branch,id)%>';
}
$(document).ready(function () { 
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'docno' , type: 'int' },
                       	{name : 'description',type:'string'},
                       	{name : 'count',type:'number'}
     				   ],
					localdata:countdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
        $("#jobStatusCountGrid").on("bindingcomplete", function (event) {
        	// your code here.
        $('#jobStatusGrid').jqxGrid('clear');	
        }); 
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#jobStatusCountGrid").jqxGrid(
            {
               width: '100%',
               height: 130,
               source: dataAdapter,
               columnsresize: true,
               editable:false,
               selectionmode: 'singlerow',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [
                       
							{ text: 'Doc No',datafield:'docno',width:'10%',hidden:true},
							{ text: 'Description', datafield: 'description',width:'70%'},
							{ text: 'Count',datafield:'count',width:'30%'}
							
         	              ]
           
            });
            
            $("#jobStatusCountGrid").on("rowdoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = event.args.visibleindex;
            		    // right click.
            		    var rightClick = event.args.rightclick; 
            		    // original event.
            		    var ev = event.args.originalEvent;
            		    // column index.
            		    var columnIndex = event.args.columnindex;
            		    // column data field.
            		    var dataField = event.args.datafield;
            		    // cell value
            		    var value = event.args.value;
            		    
            		    var booktype=$('#jobStatusCountGrid').jqxGrid('getcellvalue',rowBoundIndex,'docno');
            		   	//Booktype-if 1 then transfer,else Limo
            			$('#jobstatusdiv').load('jobStatusGrid.jsp?status='+status+'&fromdate='+fromdate+'&todate='+todate+'&branch='+branch+'&id=1&booktype='+booktype);
            		});
            });

	
            </script>
            <div id="jobStatusCountGrid"></div>
