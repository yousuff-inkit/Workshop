<%@ page import="com.dashboard.workshop.wsupdateinsurcomp.*" %>
<% ClsWSUpdateInsurCompDAO insurcocmpdao=new ClsWSUpdateInsurCompDAO();
String id = request.getParameter("id")==null?"0":request.getParameter("id");%>
<script type="text/javascript">
	var id='<%=id%>';
	var insurcompdata=[];
	if(id=="1"){
		insurcompdata= '<%=insurcocmpdao.getInsurCompany(id)%>';
    }
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'cldocno', type: 'number'   },
     						{name : 'refname', type: 'string'  }
     						
                        ],
                		 localdata: insurcompdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#insurCompSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                sortable:true,
                columns: [
                			{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '20%', cellsrenderer: function (row, column, value) {
								    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
								}   },
							{ text: 'Doc No',  datafield: 'cldocno', width: '10%',hidden:true },
							{ text: 'Insur.Comp Name', datafield: 'refname', width: '80%' }
						]
            });
            
              $('#insurCompSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex = event.args.rowindex;
                $('#insurcomp').val($('#insurCompSearchGrid').jqxGrid('getcellvalue',rowindex,'refname'));
                $('#insurcompdocno').val($('#insurCompSearchGrid').jqxGrid('getcellvalue',rowindex,'cldocno'));
            	$('#insurcompwindow').jqxWindow('close'); 
            });   
        });
    </script>
    <div id="insurCompSearchGrid"></div>
 