<%@page import="com.dashboard.workshop.gateinpasslist.ClsGateInPassListDAO"%>
<%
String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
String todate = request.getParameter("tdt")==null?"0":request.getParameter("tdt").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
String datetype =request.getParameter("datetype")==null?"0":request.getParameter("datetype");
String client =request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
String txttype =request.getParameter("txttype")==null?"0":request.getParameter("txttype").trim();
String load =request.getParameter("type")==null?"0":request.getParameter("type").trim();
String cmbcategory =request.getParameter("cmbcategory")==null?"0":request.getParameter("cmbcategory").trim();
ClsGateInPassListDAO DAO= new ClsGateInPassListDAO();
%>

 <script type="text/javascript">
 
   var data1;
   var chk='<%=check%>';
	if(chk=="1"){ 
		data1='<%=DAO.getsum(fromdate,todate,check,datetype,client,txttype,load,cmbcategory)%>';
		   }

 
 
 $(document).ready(function () { 
	 var rendererstring=function (aggregates){
        	var value=aggregates['sum'];
        	if(typeof(value) == "undefined"){
        		value=0.00;
        	}
        	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
        }
 	
      var rendererstring1=function (aggregates){
         var value1=aggregates['sum1'];
         return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
        }
      
     // prepare the data
     var source =
     {
         datatype: "json",
         datafields: [
        	                     {name : 'srno', type: 'number'   },
                                 {name : 'docno', type: 'number'   },
                                 {name : 'client', type: 'string'   },
                                 {name : 'estamt', type: 'number'   },
                                 {name : 'invamt', type: 'number'   },
                                 
                                 
                                 ],
                                 localdata: data1,
                                
                                
                                pager: function (pagenum, pagesize, oldpagenum) {
                                    // callback called when a page or page size is changed.
                                }
                                                        
                            };
                           
                            var dataAdapter = new $.jqx.dataAdapter(source,{
                                		loadError: function (xhr, status, error) {
                	                    alert(error);    
                	                    }
                		            });
                            
                            $("#jqxdetailGrid").jqxGrid(
                            {
                                width: '98%',
                                height: 530,
                                source: dataAdapter,
                                filtermode:'excel',
                                filterable: true,
                                sortable: true,
                                showfilterrow: true,
                                columnsresize: true,
                                showaggregates: true,
                             	showstatusbar:true,
                             	rowsheight:25,
                             	statusbarheight:25,
                             	enabletooltips:true,
                                selectionmode: 'singlerow',
                                editable: false,
                                localization: {thousandsSeparator: ""},
                                
                                columns: [
                                              { text: 'SrNo', datafield: 'srno', width: '5%'},
                 							  { text: 'Docno', datafield: 'docno', width: '5%'},
                							  { text: 'Client ', datafield: 'client', width: '37%' }, 
                							  { text: 'Est Amount ', datafield: 'estamt', width: '25%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }, 
                							  { text: 'Inv Amount ', datafield: 'invamt', width: '25%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring }, 
                  		                	

                                        ]
            });
                            $("#overlay, #PleaseWait").hide();
        });
 	
    </script>
    <div id="jqxdetailGrid"></div>


