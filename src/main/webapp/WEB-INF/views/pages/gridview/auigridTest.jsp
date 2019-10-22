<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>HTML5 자바스크립트 그리드(JavaScript Grid) - AUIGrid</title>

<link href="http://www.auisoft.net/aui.ico" rel="shortcut icon" />
<link href="../../resources/gridview/demo.css" rel="stylesheet"/>
<link href="../../resources/gridview/AUIGrid_style.css" rel="stylesheet">
<script type="text/javascript">
	var theme = "default";
</script>

<!-- ajax 요청을 위한 스크립트입니다. -->
<script type="text/javascript" src="../../resources/gridview/ajax.js"></script>

<!-- 데모를 위한 스크립트입니다. -->
<script type="text/javascript" src="../../resources/gridview/demo.js"></script>

<!-- 공용 Ajax 요청 스크립트 -->
<script type="text/javascript" src="../../resources/gridview/common.js"></script>

<!-- AUIGrid 라이센스 파일입니다. 그리드 출력을 위해 꼭 삽입하십시오. -->
<script type="text/javascript" src="../../resources/gridview/AUIGridLicense.js"></script>
<script type="text/javascript" src="../../resources/gridview/AUIGrid.js"></script>
<style type="text/css">

/* 커스텀 칼럼 스타일 정의 */
.aui-grid-user-custom-left {
	text-align:left;
}
.aui-grid-user-custom-right {
	text-align:right;
}
/* 커스텀 summary total  스타일 */
.aui-grid-my-footer-sum-total {
	font-weight:bold;
	text-align:right;
	color:#4374D9;
}
.aui-grid-my-footer-sum-total2 {
	text-align:right;
}
</style>

<script type="text/javascript">

// AUIGrid 생성 후 반환 ID
var myGridID;

// document ready (jQuery 의 $(document).ready(function() {}); 과 같은 역할을 합니다.
function documentReady() {  
	
	// AUIGrid 그리드를 생성합니다.
	createAUIGrid(columnLayout);
	
	// 데이터 요청, 요청 성공 시 AUIGrid 에 데이터 삽입합니다.
	requestData("./resources/json/normal_100.json");

};

// AUIGrid 칼럼 설정
// 데이터 형태는 다음과 같은 형태임,
//[{"id":"#Cust0","date":"2014-09-03","name":"Han","country":"USA","product":"Apple","color":"Red","price":746400}, { .....} ];
var columnLayout = [ {
		dataField : "name",
		headerText : "Name",
		style : "aui-grid-user-custom-left",
		renderer : {
			type : "IconRenderer",
			iconWidth : 20, // icon 가로 사이즈, 지정하지 않으면 24로 기본값 적용됨
			iconHeight : 20,
			iconTableRef :  { // icon 값 참조할 테이블 레퍼런스
				"default" : "./assets/office_man.png" // default
			}
		}
	}, {
		dataField : "country",
		headerText : "Country"
	}, {
		dataField : "product",
		headerText : "Product"
	}, {
		dataField : "color",
		headerText : "Color"
	}, {
		dataField : "price",
		headerText : "Price",
		dataType : "numeric",
		style : "aui-grid-user-custom-right"
	}, {
		dataField : "date",
		headerText : "Date"
	}
];

// 푸터 설정
var footerObject = [ {
	labelText : "∑",
	positionField : "#base"
}, {
	dataField : "price",
	positionField : "price",
	operation : "SUM",
	formatString : "#,##0",
	style : "aui-grid-my-footer-sum-total"
}, {
	dataField : "price",
	positionField : "date",
	operation : "COUNT",
	style : "aui-grid-my-footer-sum-total2"
}, {
	labelText : "Count=>",
	positionField : "phone",
	style : "aui-grid-my-footer-sum-total2"
}];

// AUIGrid 를 생성합니다.
function createAUIGrid(columnLayout) {
	
	var auiGridProps = {
			
			rowIdField : "id",
			
			editable : true,
			
			selectionMode : "multipleRows",
			
			showFooter : true,
			
			showStateColumn : true,
			
			// 칼럼 끝에서 오른쪽 이동 시 다음 행, 처음 칼럼으로 이동할지 여부
			wrapSelectionMove : true,
			
			// 사용자가 추가한 새행은 softRemoveRowMode 적용 안함. 
			// 즉, 바로 삭제함.
			softRemovePolicy : "exceptNew"
	};

	// 실제로 #grid_wrap 에 그리드 생성
	myGridID = AUIGrid.create("#grid_wrap", columnLayout, auiGridProps);
	
	// 푸터 객체 세팅
	AUIGrid.setFooter(myGridID, footerObject);
	
	
	// 에디팅 시작 이벤트 바인딩
	AUIGrid.bind(myGridID, "cellEditBegin", auiCellEditingHandler);

	// 에디팅 정상 종료 이벤트 바인딩
	AUIGrid.bind(myGridID, "cellEditEnd", auiCellEditingHandler);
	
	// 에디팅 취소 이벤트 바인딩
	AUIGrid.bind(myGridID, "cellEditCancel", auiCellEditingHandler);
	
	// 행 추가 이벤트 바인딩 
	AUIGrid.bind(myGridID, "addRow", auiAddRowHandler);
	
	// 행 삭제 이벤트 바인딩 
	AUIGrid.bind(myGridID, "removeRow", auiRemoveRowHandler);
	
	
	// 삭제 전 확인을 하고자 한다면 주석 제거 하세요.
	// 행 삭제 전 이벤트 바인딩 
	/*AUIGrid.bind(myGridID, "beforeRemoveRow", function(event) {
		var message = "삭제 확인\r" + event.type + " 이벤트 ( softRemoveRowMode : " + event.softRemoveRowMode + ")\r\n";
		message += "삭제할 개수 : " + event.items.length;
		
		var retVal = confirm(message);
		
		return retVal;
	});*/
	
}

function auiCellEditingHandler(event) {
	if(event.type == "cellEditBegin") {
		document.getElementById("editBeginDesc").innerHTML = "에디팅 시작(cellEditBegin) : ( " + event.rowIndex + ", " + event.columnIndex + " ) " + event.headerText + ", value : " + event.value;
	} else if(event.type == "cellEditEnd") {
		document.getElementById("editBeginEnd").innerHTML = "에디팅 종료(cellEditEnd) : ( " + event.rowIndex + ", " + event.columnIndex + " ) " + event.headerText + ", value : " + event.value;
	} else if(event.type == "cellEditCancel") {
		document.getElementById("editBeginEnd").innerHTML = "에디팅 취소(cellEditCancel) : ( " + event.rowIndex + ", " + event.columnIndex + " ) " + event.headerText + ", value : " + event.value;
	}
};

// 행 추가 이벤트 핸들러
function auiAddRowHandler(event) {
	//alert(event.type + " 이벤트\r\n" + "삽입된 행 인덱스 : " + event.rowIndex + "\r\n삽입된 행 개수 : " + event.items.length);
	document.getElementById("rowInfo").innerHTML = (event.type + " 이벤트 :  " + "삽입된 행 인덱스 : " + event.rowIndex + ", 삽입된 행 개수 : " + event.items.length);
}

// 행 삭제 이벤트 핸들러
function auiRemoveRowHandler(event) {
	document.getElementById("rowInfo").innerHTML = (event.type + " 이벤트 :  " + ", 삭제된 행 개수 : " + event.items.length + ", softRemoveRowMode : " + event.softRemoveRowMode);
}

var countries = ["Korea", "USA",  "UK", "Japan", "China", "France", "Italy", "Singapore", "Ireland", "Taiwan"];
var products = new Array("IPhone 5S", "Galaxy S5", "IPad Air", "Galaxy Note3", "LG G3", "Nexus 10");
var colors = new Array("Blue", "Gray", "Green", "Orange", "Pink", "Violet", "Yellow", "Red");

var cnt = 0;

// 행 추가, 삽입
function addRow() {
	
	var rowPos = document.getElementById("addSelect").value;
	
	var item = new Object();
	item.name = "AUI-" + (++cnt),
	item.country = countries[cnt % countries.length],
	item.color = colors[cnt % colors.length],
	item.product = products[cnt % products.length],
	item.price = Math.floor(Math.random() * 1000000),
	item.date = "2015/03/05"

	// parameter
	// item : 삽입하고자 하는 아이템 Object 또는 배열(배열인 경우 다수가 삽입됨)
	// rowPos : rowIndex 인 경우 해당 index 에 삽입, first : 최상단, last : 최하단, selectionUp : 선택된 곳 위, selectionDown : 선택된 곳 아래
	AUIGrid.addRow(myGridID, item, rowPos);
}

// 다수의 행 추가, 삽입
function addRowMultiple() {
	
	var rowPos = document.getElementById("multipleAddSelect").value;
	
	var item;
	var rowList = [];
	var rowCnt = Math.floor(Math.random() * 10); // 랜덤 개수
	rowCnt = Math.max(2, rowCnt);
	
	// 추가시킬 행 10개 작성
	for(var i=0; i<rowCnt; i++) { 
		rowList[i] = {
			name : "AUI-" + (++cnt),
			country : countries[i],
			color : colors[cnt % colors.length],
			product : products[cnt % products.length],
			price : Math.floor(Math.random() * 1000000),
			date : "2015/03/05"
		}
	}

	// parameter
	// item : 삽입하고자 하는 아이템 Object 또는 배열(배열인 경우 다수가 삽입됨)
	// rowPos : rowIndex 인 경우 해당 index 에 삽입, first : 최상단, last : 최하단, selectionUp : 선택된 곳 위, selectionDown : 선택된 곳 아래
	AUIGrid.addRow(myGridID, rowList, rowPos);
}

// 행 삭제
function removeRow() {
	
	var rowPos = document.getElementById("removeSelect").value;
		
	AUIGrid.removeRow(myGridID, rowPos);
}

// 삭제해서 마크 된(줄이 그어진) 행을 복원 합니다.(삭제 취소)
function restoreSoftRows() {
	
	var flag = document.getElementById("cacnelSelect").value;
	
	if(flag == "all") {
		// 전체 삭제 취소
		AUIGrid.restoreSoftRows(myGridID, "all");
	} else {
		// 선택 행 삭제 취소(선택 행이 삭제 됐다면...)
		AUIGrid.restoreSoftRows(myGridID, "selectedIndex");
	}
	
}


function resetUpdatedItems() {
	
	// 모두 초기화.
	AUIGrid.resetUpdatedItems(myGridID, "a");
}
</script>

</head>
<body>
<div class="wrap">
	<!-- header -->
	<div id="header">
		<div id="logo-bar">
			<a href="#" onclick="changeLocation('./index.html?a', 0)"> <img title="AUISoft" alt="AUISoft" src="./assets/auisoft.png"></a>
		</div>
		
		<div class="nav-buttons">
			<a id="download"  href="/dcenter.html"  class="btn btn-primary">DOWNLOAD FREE TRIAL</a>
			<a id="pricing"  href="/price.html"  class="btn btn-primary">PRICING &amp; LICENSE</a>
		</div>

		<!-- 모바일 버튼 -->
		<div id="mobileBtn" onclick="mobileBtnClick()" class="btn" >
			<span class="fnbar"></span>
			<span class="fnbar"></span>
			<span class="fnbar"></span>
		</div>

	</div>
	<!-- // end of header -->

	
	<div id="example-nav-bar">
		<a href="./assets/AUIGrid_GS.pdf" target="_blank"><img src="./assets/gs.png" width="71" height="36" style="vertical-align:middle;cursor:pointer;margin:2px;"></a>
		<a href="#" onclick="changeLocation('./index.html?a', 0)"><span id="title">AUIGrid 3.0 DEMO</span></a>
	</div>

	<!-- nav-wrapper -->
	<div id="nav-wrapper">
			<div id="root-nav">
				<ul class="root-nav-categories">
					<li>
						<span class="category">쇼케이스</span>
						<ul class="root-nav-widgets">
							<li id="sh01"><a href="javascript:changeLocation('./showcase1.html?sh01&theme')">1. 학생 출석 CRUD 그리드</a></li>
							<li id="sh02"><a href="javascript:changeLocation('./showcase2.html?sh02')">2. 프로젝트 일정 트리 그리드</a></li>
							<li id="sh03"><a href="javascript:changeLocation('./showcase3.html?sh03')">3. 채널 마케팅 예산</a></li>
							<li id="sh04"><a href="javascript:changeLocation('./showcase4n.html?sh04')">4. 실시간 주식 종목</a></li>
							<li id="sh05"><a href="javascript:changeLocation('./showcase5.html?sh05')">5. 국가별 핸드폰 판매 통계</a></li>
							<li id="sh06"><a href="javascript:changeLocation('./showcase6.html?sh06')">6. 손익 계산 내역</a></li>
							<li id="sh07"><a href="javascript:changeLocation('./showcase7.html?sh07')">7. 사원 관리(EditingDemo)</a></li>
							<li id="sh08"><a href="javascript:changeLocation('./showcase8.html?sh08')">8. DB 그리드</a></li>
							<li id="sh09"><a href="javascript:changeLocation('./showcase9.html?sh09')">9. 일별 목표치 달성률 그리드</a></li>
						</ul>
					</li>
					<li>
						<span class="category">1. 그리드 기본</span>
						<ul class="root-nav-widgets">
							<li id="ex1_1"><a href="javascript:changeLocation('./default_demo.html?ex1_1')">JSON 그리드 기본 출력</a></li>
							<li id="xex1_1"><a href="javascript:changeLocation('./default_demo_xml.html?xex1_1')">XML 그리드 기본 출력</a></li>
							<li id="cex1_1"><a href="javascript:changeLocation('./default_demo_csv.html?cex1_1')">CSV 그리드 기본 출력</a></li>
							<li id="aex1_1"><a href="javascript:changeLocation('./default_demo_array.html?aex1_1')">JS Array 그리드 기본 출력</a></li>
							
							<li id="mer_r"><a href="javascript:changeLocation('./merge_row.html?mer_r')">셀 세로 병합(row merge)</a></li>
							<li id="mer_r2"><a href="javascript:changeLocation('./merge_row_ref.html?mer_r2')">참조 후 셀 세로 병합(row merge)</a></li>
							<li id="mer_c"><a href="javascript:changeLocation('./merge_column.html?mer_c')">셀 가로 병합(column merge)<span class="new"></span></a></li>
							
							<li id="ex1_3"><a href="javascript:changeLocation('./column_fixed.html?ex1_3')">고정 칼럼(FixedColumns)</a></li>
							<li id="ex1_4"><a href="javascript:changeLocation('./row_fixed.html?ex1_4')">고정 행(FixedRows)</a></li>
							<li id="ex1_5"><a href="javascript:changeLocation('./column_row_fixed.html?ex1_5')">고정 칼럼, 행 같이 적용</a></li>
							<li id="ex1_6"><a href="javascript:changeLocation('./selection.html?ex1_6')">셀, 행 선택 모드</a></li>
							<li id="ex1_7"><a href="javascript:changeLocation('./word_wrap.html?ex1_7')">워드랩(wordWrap) - 자동 행 높이</a></li>
							<li id="ex1_8"><a href="javascript:changeLocation('./hide_column.html?ex1_8')">칼럼 보이기/숨김 설정</a></li>
							<li id="dcIdx"><a href="javascript:changeLocation('./change_columnIdx.html?dcIdx')">칼럼 위치 바꾸기 - 마우스 드래깅</a></li>
							<li id="dcIdxi"><a href="javascript:changeLocation('./change_columnIdx_api.html?dcIdxi')">칼럼 위치 바꾸기 - API </a></li>
							<li id="dcs1"><a href="javascript:changeLocation('./column_size.html?dcs1')">칼럼 사이즈 고정(px), 비율(%) 설정</a></li>
							<li id="crc0"><a href="javascript:changeLocation('./column_resize.html?crc0')">칼럼 사이즈 변경</a></li>
							<li id="rsc0"><a href="javascript:changeLocation('./resize_grid.html?rsc0')">그리드 사이즈 변경</a></li>
							<li id="st_base"><a href="javascript:changeLocation('./sorting_demo.html?st_base')">그리드 정렬(Sorting)</a></li>
							<li id="st1"><a href="javascript:changeLocation('./styling.html?st1')">동적 스타일링(Styling)</a></li>
							<li id="ma_de"><a href="javascript:changeLocation('./master_detail.html?ma_de')">Master-Details 표현</a></li>
							<li id="ma_form"><a href="javascript:changeLocation('./master_form.html?ma_form')">그리드-Form 에 확장 정보 표현</a></li>
							<li id="dep_col"><a href="javascript:changeLocation('./dependency_columns.html?dep_col')">의존적 칼럼 관계(칼럼 합계 및 연산)</a></li>
							<li id="lazy"><a href="javascript:changeLocation('./lazy_loading.html?lazy')">스크롤 최하단에서 데이터 요청(lazyLoading) </a></li>
							<li id="save"><a href="javascript:changeLocation('./save_column.html?save')">그리드 상태 저장/유지</a></li>
							<li id="ssum"><a href="javascript:changeLocation('./selection_summary.html?ssum')">셀 선택 블럭 합계, 개수 등 표시</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">2. 헤더(Header) 및 칼럼(Column)</span>
						<ul class="root-nav-widgets">
							<li id="hnor"><a href="javascript:changeLocation('./header-normal.html?hnor')">일반 그리드 헤더</a></li>
							<li id="htooltip"><a href="javascript:changeLocation('./header-tooltip.html?htooltip')">칼럼 설명 툴팁 표시</a></li>
							<li id="hgroup"><a href="javascript:changeLocation('./header-grouping.html?hgroup')">그룹형 그리드 헤더</a></li>
							<li id="hgrouph"><a href="javascript:changeLocation('./header-height.html?hgrouph')">헤더 개별 높이</a></li>
							<li id="hmerge"><a href="javascript:changeLocation('./header-merge.html?hmerge')">헤더 가로 병합(merge)</a></li>
							<li id="hnon"><a href="javascript:changeLocation('./header-non.html?hnon')">헤더 표시 안함</a></li>
							<li id="hstyle"><a href="javascript:changeLocation('./header-styling.html?hstyle')">헤더 스타일 적용</a></li>
							<li id="hmt"><a href="javascript:changeLocation('./header-multiText.html?hmt')">헤더 텍스트 개행(2줄) 표시</a></li>
							<li id="col_prop"><a href="javascript:changeLocation('./column_change_props.html?col_prop')">헤더 텍스트 등의 속성 변경</a></li>
							<li id="hmenu"><a href="javascript:changeLocation('./header_event_menu.html?hmenu')">헤더 메뉴 작성하기</a></li>
							<li id="happ"><a href="javascript:changeLocation('./header-grouping-folder.html?happ')">헤더에 열/닫기 버턴 넣기(응용)</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">3. 그리드 푸터(Footer)</span>
						<ul class="root-nav-widgets">
							<li id="ftn"><a href="javascript:changeLocation('./footer-normal.html?ftn')">일반 그리드 푸터</a></li>
							<li id="ftxt"><a href="javascript:changeLocation('./footer-text.html?ftxt')">푸터에 텍스트 지정</a></li>
							<li id="fcustom2"><a href="javascript:changeLocation('./footer-custom2.html?fcustom2')">다수의 연산값 푸터 출력</a></li>
							<li id="fcustom"><a href="javascript:changeLocation('./footer-custom.html?fcustom')">푸터 사용자 수식으로 적용</a></li>
							<li id="fstyle"><a href="javascript:changeLocation('./footer-style.html?fstyle')">푸터 스타일 적용</a></li>
							<li id="fstyle2"><a href="javascript:changeLocation('./footer-style2.html?fstyle2')">푸터 동적 스타일 적용</a></li>
							<li id="ftop"><a href="javascript:changeLocation('./footer-top.html?ftop')">푸터를 상단 위치에 출력하기(Header Summary)</a></li>
							<li id="fmg"><a href="javascript:changeLocation('./footer-merge.html?fmg')">푸터 셀 가로 병합(merge)<span class="new"></span></a></li>
						</ul>
					</li>
				</ul>
				
				<ul class="root-nav-categories">
					<li>
						<span class="category">4. 그리드 툴팁(Tooltip)</span>
						<ul class="root-nav-widgets">
							<li id="tip_n"><a href="javascript:changeLocation('./tooltip-normal.html?tip_n')">기본 그리드 툴팁</a></li>
							<li id="tip_f"><a href="javascript:changeLocation('./tooltip-function.html?tip_f')">툴팁 내용 사용자 정의</a></li>
							<li id="tip_na"><a href="javascript:changeLocation('./tooltip-native.html?tip_na')">HTML 내장 툴팁 사용</a></li>
						</ul>
					</li>
				</ul>
				
				<ul class="root-nav-categories">
					<li>
						<span class="category">5. 계층형 데이터 구조(TreeGrid)</span>
						<ul class="root-nav-widgets">
							<li id="trn"><a href="javascript:changeLocation('./treeData_default.html?trn')">계층 트리 데이터 기본</a></li>
							<li id="trn2"><a href="javascript:changeLocation('./treeData.html?trn2')">계층 트리 데이터 모두 열기</a></li>
							<li id="trn_hg"><a href="javascript:changeLocation('./treeData-header-group.html?trn_hg')">계층형 데이터(+그룹 헤더)</a></li>
							<li id="trn4"><a href="javascript:changeLocation('./treeData_open_item.html?trn4')">초기 화면 특정 행 열기</a></li>
							<li id="t_ww"><a href="javascript:changeLocation('./treeData_word_wrap.html?t_ww')">워드랩(wordWrap) - 자동 행 높이</a></li>
							<li id="trn_lz"><a href="javascript:changeLocation('./treeData_lazy_loading.html?trn_lz')">트리 하위 데이터 요청(lazyLoading)</a></li>
							<li id="trn5"><a href="javascript:changeLocation('./treeData_icon_style.html?trn5')">트리 아이콘 스타일 재정의</a></li>
							<li id="trn6"><a href="javascript:changeLocation('./treeData_icon.html?trn6')">트리 아이콘 동적 지정</a></li>
							<li id="trn_ft"><a href="javascript:changeLocation('./treeData_flat2tree.html?trn_ft')">일반 데이터를 트리로 표현하기</a></li>
							<li id="trn8"><a href="javascript:changeLocation('./treeData_lastDepth_sorting.html?trn8')">정렬 시 최하단 Depth만 적용하기</a></li>
							<li id="trn9"><a href="javascript:changeLocation('./treeData_cellmerge.html?trn9')">계층 트리 데이터 칼럼 셀 병합</a></li>
							<li id="trn10"><a href="javascript:changeLocation('./treeData_children.html?trn10')">트리 행의 부모, 자손들 얻기</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">6. 그룹핑(Grouping) 계층화</span>
						<ul class="root-nav-widgets">
							<li id="grdft"><a href="javascript:changeLocation('./grouping.html?grdft')">트리형 그룹핑 - 기본</a></li>
							<li id="grm"><a href="javascript:changeLocation('./grouping_merge.html?grm')">셀병합형 그룹핑</a></li>
							<li id="grmnb"><a href="javascript:changeLocation('./grouping_merge_nobranch.html?grmnb')">셀병합형 그룹핑 + 브랜치 표시 안함</a></li>
							<li id="gsum"><a href="javascript:changeLocation('./grouping_summary_default.html?gsum')">트리형 합계 필드(소계) 표시</a></li>
							<li id="gsumm"><a href="javascript:changeLocation('./grouping_summary_merge.html?gsumm')">셀병합형 합계 필드(소계) 표시</a></li>
							<li id="gsummc"><a href="javascript:changeLocation('./grouping_summary_merge_col.html?gsummc')">셀병합형 합계 필드(소계) 가로 병합<span class="new"></span></a></li>
							<li id="gscsum"><a href="javascript:changeLocation('./grouping_summary_custom.html?gscsum')">합계 필드 사용자 정의 - 다른 연산</a></li>
							<li id="gsprt"><a href="javascript:changeLocation('./grouping_summary_part.html?gsprt')">선택적 합계 필드 구성</a></li>
							<li id="gscus"><a href="javascript:changeLocation('./grouping_custom.html?gscus')">사용자 정의 그룹핑 하기 - API</a></li>
							<li id="gssrt"><a href="javascript:changeLocation('./grouping_sorting.html?gssrt')">정렬 유지한 채 그룹핑 실시</a></li>
							<li id="gsexp"><a href="javascript:changeLocation('./grouping_summary_exp.html?gsexp')">부분합계 칼럼 간의 expFunction 활용</a></li>
							
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">7. 필터(Filter)</span>
						<ul class="root-nav-widgets">
							<li id="ft_base"><a href="javascript:changeLocation('./filter_demo.html?ft_base')">기본 그리드 필터</a></li>
							<li id="ft_hd"><a href="javascript:changeLocation('./filter_treegrid.html?ft_hd')">트리 그리드 필터</a></li>
							<li id="ft_ac"><a href="javascript:changeLocation('./filter_grouping.html?ft_ac')">그룹핑 필터</a></li>
							<li id="ft_cxt"><a href="javascript:changeLocation('./filter_context.html?ft_cxt')">컨텍스트 메뉴로 필터 구성</a></li>
							<li id="ft_usr"><a href="javascript:changeLocation('./filter_user.html?ft_usr')">사용자 정의 필터</a></li>
							<li id="ft_usr2"><a href="javascript:changeLocation('./filter_user2.html?ft_usr2')">사용자 정의 필터2</a></li>
							<li id="ft_menu"><a href="javascript:changeLocation('./filter_custom_menu.html?ft_menu')">사용자 정의 필터 메뉴 작성하기</a></li>
							<li id="ft_lb"><a href="javascript:changeLocation('./filter_label_demo.html?ft_lb')">포매팅된 값으로 필터 메뉴 구성하기</a></li>
							
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">8. 검색(Search)</span>
						<ul class="root-nav-widgets">
							<li id="sr_base"><a href="javascript:changeLocation('./search_demo.html?sr_base')">기본 그리드 검색</a></li>
							<li id="sr_blk"><a href="javascript:changeLocation('./search_block_demo.html?sr_blk')">블럭(block) 선택 된 상태에서 검색</a></li>
							<li id="sr_hd"><a href="javascript:changeLocation('./search_treegrid.html?sr_hd')">트리 그리드 검색</a></li>
							<li id="sr_ui"><a href="javascript:changeLocation('./search_ui_demo.html?sr_ui')">그리드 검색 Ctrl+F UI</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">9. 페이징(Paging)</span>
						<ul class="root-nav-widgets">
							<li id="pg_base"><a href="javascript:changeLocation('./paging_demo.html?pg_base')">기본 그리드 페이징</a></li>
							<li id="pg_base2"><a href="javascript:changeLocation('./paging_demo2.html?pg_base2')">페이징 설정 화면</a></li>
							<li id="pg_simple"><a href="javascript:changeLocation('./paging_simple.html?pg_simple')">심플 모드 페이징</a></li>
							<li id="pg_ww"><a href="javascript:changeLocation('./paging_word_wrap.html?pg_ww')">워드랩(wordWrap)-자동 행 높이</a></li>
							<li id="pg_tree"><a href="javascript:changeLocation('./paging_tree.html?pg_tree')">트리 그리드 페이징</a></li>
							<li id="pg_stl"><a href="javascript:changeLocation('./paging_styles.html?pg_stl')">푸터와 스타일링 된 페이징</a></li>
							<li id="pg_sf"><a href="javascript:changeLocation('./paging_search.html?pg_sf')">페이징에서 검색, 필터 적용</a></li>
							<li id="pg_cus"><a href="javascript:changeLocation('./paging_custom.html?pg_cus')">사용자 정의(Custom) 페이징</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">10. 컨텍스트 메뉴</span>
						<ul class="root-nav-widgets">
							<li id="ctd"><a href="javascript:changeLocation('./context_demo.html?ctd')">기본 컨텍스트 메뉴</a></li>
							<li id="cur"><a href="javascript:changeLocation('./context_user.html?cur')">컨텍스트 메뉴 사용자 정의</a></li>
							<li id="cxe"><a href="javascript:changeLocation('./context_event.html?cxe')">헤더 컨텍스트 사용자 메뉴 구성</a></li>
							<li id="cxe2"><a href="javascript:changeLocation('./context_event2.html?cxe2')">바디 컨텍스트 사용자 메뉴 구성</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">11. 칼럼 렌더러(renderer)</span>
						<ul class="root-nav-widgets">
							<li id="rtxt"><a href="javascript:changeLocation('./renderer_text.html?rtxt')">텍스트 렌더러(기본)</a></li>
							<li id="rimg"><a href="javascript:changeLocation('./renderer_image.html?rimg')">이미지 렌더러</a></li>
							<li id="ricon"><a href="javascript:changeLocation('./renderer_icon.html?ricon')">아이콘 렌더러</a></li>
							<li id="rchk"><a href="javascript:changeLocation('./renderer_checkbox_column.html?rchk')">체크박스 렌더러</a></li>
							<li id="rchk2"><a href="javascript:changeLocation('./renderer_checkbox_column2.html?rchk2')">체크박스 렌더러 - 전체 체크</a></li>
							<li id="rbtn"><a href="javascript:changeLocation('./renderer_button.html?rbtn')">버튼 렌더러</a></li>
							<li id="rstep"><a href="javascript:changeLocation('./renderer_numberStep.html?rstep')">넘버 스텝 렌더러</a></li>
							<li id="rdrop"><a href="javascript:changeLocation('./renderer_dropdownlist.html?rdrop')">드랍다운리스트 렌더러</a></li>
							<li id="rbar"><a href="javascript:changeLocation('./renderer_bar.html?rbar')">바 게이지 렌더러</a></li>
							<li id="rlink"><a href="javascript:changeLocation('./renderer_link.html?rlink')">링크(Link) 렌더러</a></li>
							<li id="rhtml"><a href="javascript:changeLocation('./renderer_html_template.html?rhtml')">HTML 템플릿 렌더러</a></li>
							<li id="rhtml2"><a href="javascript:changeLocation('./renderer_html_template2.html?rhtml2')">HTML 템플릿 렌더러 - 편집 적용</a></li>
						</ul>
					</li>
				</ul>
				
				<ul class="root-nav-categories">
					<li>
						<span class="category">12. 칼럼 에디트렌더러(editRenderer)</span>
						<ul class="root-nav-widgets">
							<li id="erdft"><a href="javascript:changeLocation('./editRenderer_default.html?erdft')">인풋 렌더러(기본)</a></li>
							<li id="erdi"><a href="javascript:changeLocation('./editRenderer_input_btn.html?erdi')">인풋 렌더러 - editorBtn 수정 팝업</a></li>
							<li id="ercal"><a href="javascript:changeLocation('./editRenderer_calendar.html?ercal')">달력 렌더러</a></li>
							<li id="ercalb"><a href="javascript:changeLocation('./editRenderer_calendar_big.html?ercalb')">달력 렌더러 - 큰 달력 출력</a></li>
							<li id="ercalbt"><a href="javascript:changeLocation('./editRenderer_calendar_bootstrap.html?ercalbt')">달력 렌더러 - 부트스트랩 달력</a></li>
							<li id="erstep"><a href="javascript:changeLocation('./editRenderer_numberStep.html?erstep')">넘버 스텝 렌더러</a></li>
							<li id="erdrop"><a href="javascript:changeLocation('./editRenderer_dropdownlist.html?erdrop')">드랍다운리스트 렌더러</a></li>
							<li id="erdropm"><a href="javascript:changeLocation('./editRenderer_dropdown_multi.html?erdropm')">드랍다운리스트 다중선택</a></li>
							<li id="ercbx"><a href="javascript:changeLocation('./editRenderer_combobox.html?ercbx')">콤보박스 렌더러</a></li>
							<li id="ercauto"><a href="javascript:changeLocation('./editRenderer_cbx_autocomplete.html?ercauto')">콤보박스 자동완성</a></li>
							<li id="erchst"><a href="javascript:changeLocation('./editRenderer_cbx_history.html?erchst')">콤보박스 히스토리 모드</a></li>
							<li id="ercrmt"><a href="javascript:changeLocation('./editRenderer_remote.html?ercrmt')">원격(remote) 리스트 렌더러</a></li>
							<li id="ercrmt2"><a href="javascript:changeLocation('./editRenderer_remote2.html?ercrmt2')">원격 리스트로 다른 필드 채우기</a></li>
							<li id="ercdn"><a href="javascript:changeLocation('./editRenderer_condition.html?ercdn')">조건부 에디트 렌더러 동적 출력</a></li>
						</ul>
					</li>
				</ul>
				
				<ul class="root-nav-categories">
					<li>
						<span class="category">13. 스파크 차트 렌더러</span>
						<ul class="root-nav-widgets">
							<li id="spl"><a href="javascript:changeLocation('./spark-line.html?spl')">스파크 라인(Line) 렌더러</a></li>
							<li id="spc"><a href="javascript:changeLocation('./spark-column.html?spc')">스파크 칼럼(Column) 렌더러</a></li>
							<li id="spwl"><a href="javascript:changeLocation('./spark-winloss.html?spwl')">스파크 승패(WinLoss) 렌더러</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">14. 엑스트라 렌더러</span>
						<ul class="root-nav-widgets">
							<li id="ernum"><a href="javascript:changeLocation('./extra_renderer_rownum.html?ernum')">행 번호(RowNum) </a></li>
							<li id="estcol"><a href="javascript:changeLocation('./extra_renderer_state_column.html?estcol')">행 상태 칼럼</a></li>
							<li id="erchk"><a href="javascript:changeLocation('./extra_renderer_checkbox.html?erchk')">엑스트라 체크박스 </a></li>
							<li id="erchkrc"><a href="javascript:changeLocation('./extra_renderer_checkbox_by_rowclick.html?erchkrc')">행 클릭으로 체크박스 체크/해제</a></li>
							<li id="erchkt"><a href="javascript:changeLocation('./extra_renderer_checkbox_tree.html?erchkt')">엑스트라 체크박스 - 트리 그리드</a></li>
							<li id="erchkta"><a href="javascript:changeLocation('./extra_renderer_checkbox_all.html?erchkta')">엑스트라 체크박스 - 전체 체크 제어</a></li>
							<li id="erdio"><a href="javascript:changeLocation('./extra_renderer_radio.html?erdio')">엑스트라 라디오버튼</a></li>
						</ul>
					</li>
				</ul>
				
				<ul class="root-nav-categories">
					<li>
						<span class="category">15. 사용자 정의(Custom) 렌더러</span>
						<ul class="root-nav-widgets">
							<li id="ren_desc"><a href="javascript:changeLocation('./renderer_custom_desc.html?ren_desc')">사용자 정의 렌더러란?(개념 설명)</a></li>
							<li id="ren_cus_1"><a href="javascript:changeLocation('./renderer_custom_1.html?ren_cus_1')">사용자 정의 렌더러 샘플 1</a></li>
							<li id="ren_cus_2"><a href="javascript:changeLocation('./renderer_custom_2.html?ren_cus_2')">사용자 정의 렌더러 샘플 2</a></li>
							<li id="ren_cus_3"><a href="javascript:changeLocation('./renderer_custom_3.html?ren_cus_3')">사용자 정의 렌더러 샘플 3</a></li>
						</ul>
					</li>
				</ul>
				
				<ul class="root-nav-categories">
					<li>
						<span class="category">16. 포매팅(Formatting)</span>
						<ul class="root-nav-widgets">
							<li id="ftnum"><a href="javascript:changeLocation('./formatter.html?ftnum')">숫자 포맷팅</a></li>
							<li id="ftdate"><a href="javascript:changeLocation('./formatter-date.html?ftdate')">날짜 포맷팅</a></li>
							<li id="ftcst"><a href="javascript:changeLocation('./formatter-custom.html?ftcst')">사용자 정의(Custom) 포매팅</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories"> 
					<li>
						<span class="category">17. 그리드 편집(Editing)</span>
						<ul class="root-nav-widgets">
							<li id="edft"><a href="javascript:changeLocation('./editing_default.html?edft')">기본 그리드 편집</a></li>
							<li id="edft2"><a href="javascript:changeLocation('./editing_default2.html?edft2')">기본 그리드 편집2</a></li>
							<li id="edftdn"><a href="javascript:changeLocation('./editing_dynamic.html?edftdn')">동적으로 편집 가능 여부 결정</a></li>
							<li id="ecopy"><a href="javascript:changeLocation('./editing_copy.html?ecopy')">셀 Copy, Paste(Ctrl+C, Ctrl+V)</a></li>
							<li id="ecopy2"><a href="javascript:changeLocation('./editing_copy2.html?ecopy2')">빈 그리드에 Paste (Ctrl + V)</a></li>
							<li id="egs"><a href="javascript:changeLocation('./editing_grouping_summary.html?egs')">그룹핑 상태에서 편집</a></li>
							<li id="etd"><a href="javascript:changeLocation('./editing_treeData.html?etd')">트리 그리드(계층형) 편집</a></li>
							<li id="etd2"><a href="javascript:changeLocation('./editing_treeData2.html?etd2')">트리 그리드 Depth 편집</a></li>
							<li id="n2t"><a href="javascript:changeLocation('./normal_to_tree.html?n2t')">일반 그리드&lt;-&gt;트리로 만들기</a></li>
							<li id="estc"><a href="javascript:changeLocation('./editing_validate.html?estc')">유효성 검사(Validating)</a></li>
							<li id="eren"><a href="javascript:changeLocation('./editing_renderer.html?eren')">유형별 칼럼 편집 렌더러</a></li>
							<li id="erdo"><a href="javascript:changeLocation('./editing_readonly.html?erdo')">칼럼 편집 불가(readonly) 설정 하기</a></li>
							<li id="epvt"><a href="javascript:changeLocation('./editing_prevent.html?epvt')">읽기전용 동적 셀 및 행 설정하기</a></li>
							<li id="erdr"><a href="javascript:changeLocation('./editing_skip_readonly.html?erdr')">읽기전용 칼럼 키 이동 건너 뛰기</a></li>
							<li id="esval"><a href="javascript:changeLocation('./editing_setvalue.html?esval')">셀, 행 값 변경하기</a></li>
							<li id="ecust"><a href="javascript:changeLocation('./editing_custom.html?ecust')">팝업 형태로 수정하기</a></li>
							<li id="efcells"><a href="javascript:changeLocation('./editing_fixed_cells.html?efcells')">고정 칼럼, 행 편집 가능 여부</a></li>
							<li id="ecrud"><a href="javascript:changeLocation('./editing_rowcrud.html?ecrud')">행(rows) 추가, 삽입, 삭제</a></li>
							<li id="ermr"><a href="javascript:changeLocation('./editing_remove_rows.html?ermr')">행(rows) 삭제, 삭제 취소</a></li>
							<li id="emoves2"><a href="javascript:changeLocation('./editing_move_rows.html?emoves2')">행(rows) 위, 아래로 이동시키기</a></li>
							<li id="ecrud2"><a href="javascript:changeLocation('./editing_rowcrud2.html?ecrud2')">추가, 삽입, 삭제된 행 얻기</a></li>
							
							<li id="ehadd"><a href="javascript:changeLocation('./editing_column_crud.html?ehadd')">열(columns) 추가, 삽입, 삭제<span class="new"></span></a></li>
							<li id="ehaddt"><a href="javascript:changeLocation('./editing_column_tree_crud.html?ehaddt')">열(columns)-그룹형 삽입, 삭제<span class="new"></span></a></li>
							
							<li id="post"><a href="javascript:changeLocation('./editing_post_to_server.html?post')">추가, 삽입, 삭제된 행 서버로 전송하기</a></li>
							<li id="tran_st"><a href="javascript:changeLocation('./transaction_state.html?tran_st')">DB 트랜잭션 응답 처리<span class="new"></span></a></li>
							<li id="ersm"><a href="javascript:changeLocation('./editing_remove_new_rows.html?ersm')">소프트제거모드 새 행(newRow) 정책</a></li>
							<li><a href="./editing_touch_device.html" target="_blank">스마트-모바일 기기 최적화 편집</a></li>
						</ul>
					</li>
				</ul>
				
				<ul class="root-nav-categories">
					<li>
						<span class="category">18. 수정 취소 및 복구(Ctrl+Z, Y)</span>
						<ul class="root-nav-widgets">
							<li id="rer"><a href="javascript:changeLocation('./restore_edited_row.html?rer')">수정 행 복구하기(수정 취소)</a></li>
							<li id="rers"><a href="javascript:changeLocation('./restore_edited_row_state.html?rers')">엑스트라 행 상태 칼럼에서 복구하기</a></li>
							<li id="rur1"><a href="javascript:changeLocation('./editing_undo_redo.html?rur1')">실행 취소(Undo), 다시 실행(Redo)</a></li>
							<li id="rur2"><a href="javascript:changeLocation('./editing_undo_redo_soft.html?rur2')">실행 취소(Undo), 다시 실행(Redo) - 소프트 제거 모드</a></li>
							<li id="rur3"><a href="javascript:changeLocation('./editing_undo_redo_tree.html?rur3')">트리 그리드 Undo, Redo</a></li>
							<li id="rur4"><a href="javascript:changeLocation('./editing_undo_redo_tree_soft.html?rur4')">트리 그리드 Undo, Redo - 소프트 제거 모드</a></li>
						</ul>
					</li>
				</ul>
				
				<ul class="root-nav-categories">
					<li>
						<span class="category">19. 엑셀, PDF 등 내보내기(Export)</span>
						<ul class="root-nav-widgets">
							<li id="exp_0"><a href="javascript:changeLocation('./export.html?exp_0')">Export 가능한 형식(엑셀, PDF 등)</a></li>
							<li id="exp_t"><a href="javascript:changeLocation('./export_tree.html?exp_t')">트리그리드 Export (엑셀, PDF)</a></li>
							<li id="exp_s"><a href="javascript:changeLocation('./export_styles.html?exp_s')">동적 스타일 Export (엑셀, PDF)</a></li>
							<li id="exp_h"><a href="javascript:changeLocation('./export_except_columns.html?exp_h')">히든 칼럼 내보내기 방식(엑셀)</a></li>
							<li id="exp_u"><a href="javascript:changeLocation('./export_user_header_footer.html?exp_u')">제목 등의 정보 Export(엑셀, PDF)</a></li>
							<li id="exp_r"><a href="javascript:changeLocation('./export_report.html?exp_r')">결재란 함께 Export(엑셀)</a></li>
							<li id="exp_pf"><a href="javascript:changeLocation('./export_pdf_fonts.html?exp_pf')">PDF 사용 가능한 폰트</a></li>
							<li id="exp_bd"><a href="javascript:changeLocation('./export_bigdata.html?exp_bd')">대용량 내보내기(엑셀, CSV)</a></li>
							<li id="exp_prg"><a href="javascript:changeLocation('./export_progress.html?exp_prg')">진행바(progressBar) 표시(엑셀, CSV)<span class="new"></span></a></li>
							<li id="exp_ls"><a href="javascript:changeLocation('./export_local_server.html?exp_ls')">Export 로컬 or 서버 다운로드</a></li>
							
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">20. 이벤트 및 기타</span>
						<ul class="root-nav-widgets">
							<li id="e_ready"><a href="javascript:changeLocation('./ready_event.html?e_ready')">완료(ready) 이벤트</a></li>
							<li id="c_schange"><a href="javascript:changeLocation('./cell_selection_change.html?c_schange')">셀 선택 변경 이벤트</a></li>
							<li id="c_click"><a href="javascript:changeLocation('./cell_click.html?c_click')">셀 클릭 이벤트</a></li>
							<li id="c_dclick"><a href="javascript:changeLocation('./cell_double_click.html?c_dclick')">셀 더블 클릭 이벤트</a></li>
							<li id="key_evt"><a href="javascript:changeLocation('./keyboard_event.html?key_evt')">키보드 이벤트(단축키 재정의)</a></li>
							<li id="h_click"><a href="javascript:changeLocation('./header_click.html?h_click')">헤더 클릭 이벤트</a></li>
							<li id="f_click"><a href="javascript:changeLocation('./footer_click.html?f_click')">푸터 클릭 이벤트</a></li>
							<li id="cre_dest"><a href="javascript:changeLocation('./create_destroy.html?cre_dest')">그리드 동적 제거 및 생성</a></li>
							<li id="hcl"><a href="javascript:changeLocation('./change_columnLayout.html?hcl')">칼럼 레이아웃 동적 변경<span class="new"></span></a></li>
							<li id="big"><a href="javascript:changeLocation('./bigdata.html?big')">대용량 출력 예</a></li>
							<li id="bigmc"><a href="javascript:changeLocation('./multiple_columns.html?bigmc')">다수의 칼럼 출력 예</a></li>
							<li id="sc_cu"><a href="javascript:changeLocation('./scroll_custom.html?sc_cu')">스크롤 위치 및 사이즈 지정</a></li>
							<li id="sc_lv"><a href="javascript:changeLocation('./livescroll.html?sc_lv')">라이브 스크롤(liveScrolling) 해제</a></li>
							<li id="sc_st"><a href="javascript:changeLocation('./selection_style.html?sc_st')">Cell-셀렉션 스타일 변경</a></li>
							<li id="sc_lscv"><a href="javascript:changeLocation('./default_demo_localfile.html?sc_lscv')">CSV 파일로 그리드 데이터 삽입</a></li>
							<li id="sc_lsxl"><a href="javascript:changeLocation('./default_demo_localxlsx.html?sc_lsxl')">엑셀 임포팅으로 그리드 출력</a></li>
							<li id="sc_rb"><a href="javascript:changeLocation('./messages_demo.html?sc_rb')">다국어(리소스번들) 설정하기</a></li>
							<li id="efile"><a href="javascript:changeLocation('./file_demo.html?efile')">그리드에서 파일 선택 및 업로드 하기</a></li>
						</ul>
					</li>
				</ul>
				<ul class="root-nav-categories">
					<li>
						<span class="category">21. 연동 및 통합(Integration)</span>
						<ul class="root-nav-widgets">
							<li id="inte_accs"><a href="javascript:changeLocation('./integration_jqueryui_accor.html?inte_accs')">jQueryUI Accordion 에서 작성하기</a></li>
							<li id="inte_tabs"><a href="javascript:changeLocation('./integration_jqueryui.html?inte_tabs')">jQueryUI Tab 에서 동적 작성하기</a></li>
							<li id="inte_dlg"><a href="javascript:changeLocation('./integration_jqueryui_dial.html?inte_dlg')">jQueryUI Dialog 에서 작성하기</a></li>
							<li id="inte_mdl"><a href="javascript:changeLocation('./integration_bootstrap_modal.html?inte_mdl')">Bootstrap Modal 에서 작성하기</a></li>
						</ul>
					</li>
				</ul>
			</div>
	</div>	<div id="main_top">
		<span>테마 선택 : </span>
		<select id="themeSelect" onchange="themeSelectHandler()" style="width:200px;">
			<option value="default">Default Theme</option>
			<option value="dark">Dark Theme</option>
			<option value="blue">Blue Theme</option>
			<option value="modern">Modern Theme</option>
			<option value="classic">Classic Theme</option>
		</select>
	</div>
	<!-- // end of nav-wrapper --><div id="main">
	<div class="desc">
		<ul class="nav_u">
			<li>■ 단일 행 추가 : </li>
			<li><select id="addSelect">
				<option value="first" selected="selected">최상단에 행추가</option>
				<option value="selectionUp">선택 행 위에 추가</option>
				<option value="selectionDown">선택 행 아래에 추가</option>
				<option value="5">rowIndex 5에 추가</option>
				<option value="last">최하단에 행추가</option>
			</select></li>
			<li><input type="button" class="btn" onclick="addRow()" value="추가하기"></li>
		</ul>
		
		<ul class="nav_u">
			<li>■ 다수의 행 추가 : </li>
			<li><select id="multipleAddSelect">
				<option value="first" selected="selected">다수의 행 최상단에에 삽입</option>
				<option value="last">다수의 행 최하단 추가</option>
			</select>	</li>
			<li><input type="button" class="btn" onclick="addRowMultiple()" value="추가하기"></li>
		</ul>
		
		<ul class="nav_u">
			<li>■ 행 삭제 : </li>
			<li><select id="removeSelect">
				<option value="selectedIndex" selected="selected">선택 행(들) 삭제</option>
				<option value="5">rowIndex 5 삭제</option>
			</select></li>
			<li><input type="button" class="btn" onclick="removeRow()" value="삭제하기"></li>
			
			<li><select id="cacnelSelect">
				<option value="selectedIndex" selected="selected">선택행 삭제 아이템 복원(삭제 취소)</option>
				<option value="all">전체 삭제 아이템들 복원</option>
			</select></li>
			<li><input type="button" class="btn" onclick="restoreSoftRows()" value="복원하기"></li>
		</ul>
		
		<p><span onclick="resetUpdatedItems()" class="btn">그리드 추가, 수정, 삭제 상태 정보 초기화</span></p>
		
	</div>
	<div>
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="grid_wrap" style="width:1200px; height:480px; margin:0 auto;"></div>
	</div>
	<div class="desc_bottom">
		<p id="rowInfo"></p>
		<p id="editBeginDesc"></p>
		<p id="editBeginEnd"></p>
	</div>
</div>
<div id="footer">
     <div class="copyright">
        <p>Copyright © 2017 AUISoft </p>
    </div>
</div>

</div>
</body>
</html>