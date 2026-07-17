<%@page import="com.operations.marketing.leasepricerequestalfahim.*" %>
<%
ClsLeasePriceRequestAlfahimDAO viewDAO=new ClsLeasePriceRequestAlfahimDAO();
%>
<script type="text/javascript">
var kmdata= '<%=viewDAO.getKm()%>';	 
$(document).ready(function () { 	
      var source =
      {
          datatype: "json",
          datafields: [
                      {name : 'doc_no', type: 'string'  },
                      {name : 'months', type: 'string'  },
                      {name : 'km',type:'string'}
					
                  ],
          		
           localdata: kmdata,
          
          pager: function (pagenum, pagesize, oldpagenum) {
              // callback called when a page or page size is changed.
          }
                                  
      };
   
      var dataAdapter = new $.jqx.dataAdapter(source);
      
      $("#kmSearch").jqxGrid(
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
                    { text: 'Doc No', datafield: 'doc_no', width: '15%'},
                    { text: 'Months', datafield: 'months', width: '35%' },
                    { text: 'Km',datafield:'km',width:'50%'}
		  ]
      });
      
    $('#kmSearch').on('rowdoubleclick', function (event) {
      	var rowindex1 =$('#rowindex').val();
          var rowindex2 = event.args.rowindex;
          $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "ldur" ,$('#kmSearch').jqxGrid('getcellvalue', rowindex2, "months"));
          $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "kmusage" ,$('#kmSearch').jqxGrid('getcellvalue', rowindex2, "km"));
          $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "residualkmdocno" ,$('#kmSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
          document.getElementById("errormsg").innerText="";
        $('#kmsearchwindow').jqxWindow('close'); 
      }); 
  });
</script>
<div id="kmSearch"></div>