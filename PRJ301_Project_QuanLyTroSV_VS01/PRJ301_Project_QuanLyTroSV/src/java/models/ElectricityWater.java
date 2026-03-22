package models;

import java.sql.Timestamp;

public class ElectricityWater {
    private int id;
    private int roomId;
    private int month;
    private int year;
    private int electricPrevious;
    private int electricCurrent;
    private int waterPrevious;
    private int waterCurrent;
    private double electricUnitPrice;
    private double waterUnitPrice;
    private Timestamp createdAt;
    private String roomNumber;

    public ElectricityWater() {}

    public ElectricityWater(int id, int roomId, int month, int year, int electricPrevious, int electricCurrent,
                            int waterPrevious, int waterCurrent, double electricUnitPrice, double waterUnitPrice, Timestamp createdAt) {
        this.id = id;
        this.roomId = roomId;
        this.month = month;
        this.year = year;
        this.electricPrevious = electricPrevious;
        this.electricCurrent = electricCurrent;
        this.waterPrevious = waterPrevious;
        this.waterCurrent = waterCurrent;
        this.electricUnitPrice = electricUnitPrice;
        this.waterUnitPrice = waterUnitPrice;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }
    public int getMonth() { return month; }
    public void setMonth(int month) { this.month = month; }
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
    public int getElectricPrevious() { return electricPrevious; }
    public void setElectricPrevious(int electricPrevious) { this.electricPrevious = electricPrevious; }
    public int getElectricCurrent() { return electricCurrent; }
    public void setElectricCurrent(int electricCurrent) { this.electricCurrent = electricCurrent; }
    public int getWaterPrevious() { return waterPrevious; }
    public void setWaterPrevious(int waterPrevious) { this.waterPrevious = waterPrevious; }
    public int getWaterCurrent() { return waterCurrent; }
    public void setWaterCurrent(int waterCurrent) { this.waterCurrent = waterCurrent; }
    public double getElectricUnitPrice() { return electricUnitPrice; }
    public void setElectricUnitPrice(double electricUnitPrice) { this.electricUnitPrice = electricUnitPrice; }
    public double getWaterUnitPrice() { return waterUnitPrice; }
    public void setWaterUnitPrice(double waterUnitPrice) { this.waterUnitPrice = waterUnitPrice; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public int getElectricUsage() { return electricCurrent - electricPrevious; }
    public int getWaterUsage() { return waterCurrent - waterPrevious; }
    public double getElectricCost() { return getElectricUsage() * electricUnitPrice; }
    public double getWaterCost() { return getWaterUsage() * waterUnitPrice; }
    public double getTotalCost() { return getElectricCost() + getWaterCost(); }
}
