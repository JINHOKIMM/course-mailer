package com.school.coursemailer.service;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Service
public class ExcelService {

    public void createCourseListExcel(List<Map<String, Object>> courses, HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Course List");

        // --- Styling ---
        // Header Style
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        headerStyle.setAlignment(HorizontalAlignment.CENTER);
        headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerFont.setColor(IndexedColors.BLACK.getIndex());
        headerStyle.setFont(headerFont);

        // Data Cell Style (Center Align)
        CellStyle dataCellStyle = workbook.createCellStyle();
        dataCellStyle.setAlignment(HorizontalAlignment.CENTER);
        dataCellStyle.setVerticalAlignment(VerticalAlignment.CENTER);

        // Data Cell Style (Left Align)
        CellStyle leftAlignStyle = workbook.createCellStyle();
        leftAlignStyle.setAlignment(HorizontalAlignment.LEFT);
        leftAlignStyle.setVerticalAlignment(VerticalAlignment.CENTER);


        // Create header row
        String[] headers = {"No", "Course Name", "Period", "Room", "Student Count", "Max Seats"};
        Row headerRow = sheet.createRow(0);
        headerRow.setHeightInPoints(25);
        for (int i = 0; i < headers.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

        // Populate data rows
        int rowNum = 1;
        for (Map<String, Object> course : courses) {
            Row row = sheet.createRow(rowNum++);
            row.setHeightInPoints(20);

            Cell cell0 = row.createCell(0);
            cell0.setCellValue(rowNum -1); // "No" column
            cell0.setCellStyle(dataCellStyle);

            Cell cell1 = row.createCell(1);
            cell1.setCellValue(String.valueOf(course.get("course_name")));
            cell1.setCellStyle(leftAlignStyle); // Left align for course name

            Cell cell2 = row.createCell(2);
            cell2.setCellValue(String.valueOf(course.get("period")));
            cell2.setCellStyle(dataCellStyle);

            Cell cell3 = row.createCell(3);
            cell3.setCellValue(String.valueOf(course.get("room")));
            cell3.setCellStyle(dataCellStyle);

            Cell cell4 = row.createCell(4);
            cell4.setCellValue(String.valueOf(course.get("student_count")));
            cell4.setCellStyle(dataCellStyle);

            Cell cell5 = row.createCell(5);
            cell5.setCellValue(String.valueOf(course.get("max_seats")));
            cell5.setCellStyle(dataCellStyle);
        }

        // Auto-size columns
        for (int i = 0; i < headers.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Set response headers for file download
        String formattedDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String fileName = String.format("CourseList(%s).xlsx", formattedDate);

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        workbook.write(response.getOutputStream());
        workbook.close();
    }
}
