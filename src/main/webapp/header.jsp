<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
<style>
    /* Phong cách tối giản, chuẩn mực phần mềm quản trị nghiệp vụ */
    body {
        background-color: #f4f6f9;
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        color: #212529;
    }
    .restman-navbar {
        background-color: #212529; /* Màu than tối giản, trang nhã */
        border-bottom: 1px solid #343a40;
    }
    .restman-card {
        background: #ffffff;
        border: 1px solid #dee2e6;
        border-radius: 6px;
    }
    .btn-restman {
        background-color: #0d6efd; /* Xanh chuẩn Bootstrap, thanh lịch */
        color: #ffffff;
        border-radius: 4px;
        font-weight: 500;
        border: 1px solid #0d6efd;
    }
    .btn-restman:hover {
        background-color: #0b5ed7;
        color: #ffffff;
        border-color: #0a58ca;
    }
    /* Loại bỏ hiệu ứng chuyển động, rung nảy */
    .btn, .btn:hover, .btn-restman, .btn-restman:hover, .restman-card, .table {
        transition: none !important;
        transform: none !important;
        box-shadow: none !important;
    }
    /* Bảng dữ liệu phẳng, sáng, sạch sẽ */
    .table-restman thead {
        background-color: #f1f3f5;
        color: #212529;
        border-bottom: 2px solid #dee2e6;
    }
    .table-restman th {
        font-weight: 600;
        color: #343a40;
    }
    .food-thumb {
        width: 64px;
        height: 48px;
        object-fit: cover;
        border-radius: 4px;
        border: 1px solid #dee2e6;
    }
    .badge-food {
        background-color: #0d6efd;
        color: #ffffff;
    }
    .badge-combo {
        background-color: #fd7e14;
        color: #ffffff;
    }
</style>
<script type="text/javascript">
    function openPage(pageURL) {
        window.location.href = pageURL;
    }
</script>