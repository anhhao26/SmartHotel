package com.smarthotel.model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Rooms")
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "RoomID")
    private Integer roomID;

    @Column(name = "RoomNumber") 
    private String roomNumber;

    @Column(name = "Floor")
    private Integer floor;

    @Column(name = "Status")
    private String status = "Available";

    @Column(name = "Price")
    private Double price;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "RoomTypeID")
    private RoomType roomType;

    // THÊM: Liên kết 1-N với RoomImage
    @OneToMany(mappedBy = "room", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<RoomImage> images;

    public Room() {}

    // Lấy ảnh bìa chính
    public String getPrimaryImageUrl() {
        if (images != null && !images.isEmpty()) {
            for (RoomImage img : images) {
                if (img.isPrimary()) {
                    return img.getImageUrl();
                }
            }
        }
        return "https://via.placeholder.com/400x300?text=Chua+Co+Anh"; 
    }

    public void setPrimaryImageUrl(String primaryImageUrl) {}

    public Integer getRoomID() { return roomID; }
    public void setRoomID(Integer roomID) { this.roomID = roomID; }
    
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    
    public Integer getFloor() { return floor; }
    public void setFloor(Integer floor) { this.floor = floor; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Double getPrice() { 
        if (price != null && price > 0) return price;
        if (roomType != null && roomType.getPricePerNight() != null) return roomType.getPricePerNight().doubleValue();
        return 0.0; 
    }
    public void setPrice(Double price) { this.price = price; }

    public RoomType getRoomType() { return roomType; }
    public void setRoomType(RoomType roomType) { this.roomType = roomType; }

    public List<RoomImage> getImages() { return images; }
    public void setImages(List<RoomImage> images) { this.images = images; }
}