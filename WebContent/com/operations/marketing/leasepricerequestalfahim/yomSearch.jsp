<%@page import="com.operations.marketing.leasepricerequestalfahim.*" %>
<%
ClsLeasePriceRequestAlfahimDAO viewDAO=new ClsLeasePriceRequestAlfahimDAO();%>
<script type="text/javascript">
var yomdata= '<%=viewDAO.getYom()%>';	 
$(document).ready(function () { 	
      var source =
      {
          datatype: "json",
          datafields: [
                      {name : 'doc_no', type: 'string'  },
                      {name : 'yom', type: 'string'  }
					
                  ],
          		
           localdata: yomdata,
          
          pager: function (pagenum, pagesize, oldpagenum) {
              // callback called when a page or page size is changed.
          }
                                  
      };
   
      var dataAdapter = new $.jqx.dataAdapter(source);
      
      $("#yomSearch").jqxGrid(
      {
          width: '100%',
          height: 330,
          source: dataAdapter,
          columnsresize: true,
          altRows: true,
          showfilterrow: true, 
          filterable: true, 
          selectionmode: 'singlerow',
          columns: [
                    { text: 'Doc No', datafield: 'doc_no', width: '25%'},
                    { text: 'Yom', datafield: 'yom', width: '75%' }
		  ]
      });
      
    $('#yomSearch').on('rowdoubleclick', function (event) {
      	var rowindex1 =$('#rowindex').val();
          var rowindex2 = event.args.rowindex;
          $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "yom" ,$('#yomSearch').jqxGrid('getcellvalue', rowindex2, "yom"));
          $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "yomid" ,$('#yomSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
          document.getElementById("errormsg").innerText="";
        $('#yomsearchwindow').jqxWindow('close'); 
      }); 
  });
</script>
<div id="yomSearch"></div>