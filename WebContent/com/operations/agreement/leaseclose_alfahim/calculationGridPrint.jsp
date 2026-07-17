
 <%@page import="com.operations.agreement.leaseagmt_alfahim.*"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 

ClsLeaseAgmtAlFahimDAO agmtdao=new ClsLeaseAgmtAlFahimDAO();
String rentaldoc=request.getParameter("rentaldoc")==null?"0":request.getParameter("rentaldoc").toString();


 %>

<script type="text/javascript">
var  datacalc;
var temp='<%=rentaldoc%>';


var datacalc='<%=agmtdao.ralistgridload(rentaldoc)%>'; 

        $(document).ready(function () { 	
        	 var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' +  value + '</div>';
               }
        	 
        	
                
        	var source =
            {
                datatype: "json",
                datafields: [
    {name : 'description' , type: 'string' },
	{name : 'qty' , type:'string'},
	{name : 'total' , type:'number'}
                 ],
                localdata: datacalc,
                //url: url,
          
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	
        	  $('#calculationgrid').on('bindingcomplete', function (event) { 
          	    var summaryData= $("#calculationgrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
         
          	 
          	 if(typeof(summaryData.sum)=="undefined")
          		 {
          	 
                  document.getElementById("totalpaid").innerText="";
          		 }
          	 else
          		 {
          		document.getElementById("totalpaid").innerText=summaryData.sum;
          		 }
          	    });
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
          
            $("#calculationgrid").jqxGrid(
            {
                width: '100%',
                height: 250,
                source: dataAdapter,
                rowsheight:18,
                localization: {thousandsSeparator: ""},
                statusbarheight:25,
               // columnsresize: true,
                columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
             	showaggregates:true,
                showstatusbar:true,
                //Add row method
                columns: [

{ text: 'Rate Description', datafield: 'description', width: '53%',editable:false},
{ text: 'Qty',  datafield: 'qty',  width: '15%',editable:false,cellsalign:'right',align:'right' },
{ text: 'Total',  datafield: 'total',  width: '15%'  ,editable:false ,cellsformat: 'd2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},


], /* columngroups: 
	                     [
	                       { text: 'Balance', align: 'center', name: 'Balance',width:10 }
	                    
	                     ] */
            });
            
            
       var rows=$("#calculationgrid").jqxGrid("getrows");
       var rowlength=rows.length;
       if(rowlength==0){
            $("#calculationgrid").jqxGrid("addrow", null, {});
       }
        });
            </script>
            <div id="calculationgrid"></div>