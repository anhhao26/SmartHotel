package dao;

import model.Room;
import model.RoomImage;
import model.RoomType;
import util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class RoomDAO {

    public Room findByRoomNumber(String roomNumber) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.roomType LEFT JOIN FETCH r.images WHERE r.roomNumber = :rn";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("rn", roomNumber);
            List<Room> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } finally {
            em.close();
        }
    }

    public long countRooms() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT COUNT(r) FROM Room r", Long.class).getSingleResult();
        } finally {
            em.close();
        }
    }

    public List<Room> findAllRooms() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getEntityManagerFactory().getCache().evictAll();
            em.clear();
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.roomType LEFT JOIN FETCH r.images ORDER BY r.floor, r.roomNumber";
            return em.createQuery(jpql, Room.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Room> findRoomsByStatus(String status) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.roomType LEFT JOIN FETCH r.images WHERE r.status = :status ORDER BY r.roomNumber";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("status", status);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Room> searchRooms(String keyword) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.roomType LEFT JOIN FETCH r.images " +
                         "WHERE UPPER(r.roomNumber) LIKE UPPER(:kw) " +
                         "OR UPPER(r.roomType.typeName) LIKE UPPER(:kw) " +
                         "ORDER BY r.roomNumber";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public boolean update(Room room) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(room);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public List<RoomType> getAllRoomTypes() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT rt FROM RoomType rt", RoomType.class).getResultList();
        } finally {
            em.close();
        }
    }

    public boolean addRoom(String roomNumber, int typeId, int floor, double price) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            RoomType rt = em.find(RoomType.class, typeId);

            Room newRoom = new Room();
            newRoom.setRoomNumber(roomNumber);
            newRoom.setFloor(floor);
            newRoom.setPrice(price);
            newRoom.setStatus("Available");
            newRoom.setRoomType(rt);

            em.persist(newRoom);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean updateRoomPrice(String roomNumber, double newPrice) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.images WHERE r.roomNumber = :rn";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("rn", roomNumber);
            List<Room> list = query.getResultList();

            if (!list.isEmpty()) {
                Room r = list.get(0);
                r.setPrice(newPrice);
                em.merge(r);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean deleteRoom(String roomNumber) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.images WHERE r.roomNumber = :rn";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("rn", roomNumber);
            List<Room> list = query.getResultList();

            if (!list.isEmpty()) {
                Room r = list.get(0);
                if ("Available".equals(r.getStatus())) {
                    em.remove(r);
                    em.getTransaction().commit();
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean updateRoomInfo(String roomNumber, int typeId, double price) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.images WHERE r.roomNumber = :rn";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("rn", roomNumber);
            List<Room> list = query.getResultList();

            RoomType rt = em.find(RoomType.class, typeId);
            if (!list.isEmpty() && rt != null) {
                Room r = list.get(0);
                r.setRoomType(rt);
                r.setPrice(price);
                em.merge(r);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean addRoomImage(String roomNumber, String imageUrl, boolean isPrimary) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.images WHERE r.roomNumber = :rn";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("rn", roomNumber);
            List<Room> list = query.getResultList();

            if (!list.isEmpty()) {
                Room room = list.get(0);

                if (isPrimary && room.getImages() != null) {
                    for (RoomImage oldImg : room.getImages()) {
                        oldImg.setPrimary(false);
                        em.merge(oldImg);
                    }
                }

                RoomImage img = new RoomImage();
                img.setImageUrl(imageUrl);
                img.setRoom(room);
                img.setPrimary(isPrimary);
                em.persist(img);

                if (isPrimary || room.getImages() == null || room.getImages().isEmpty()) {
                    img.setPrimary(true);
                    em.merge(img);
                }
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean deleteRoomImage(int imageId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            RoomImage img = em.find(RoomImage.class, imageId);
            if (img != null) {
                em.remove(img);
                em.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean setPrimaryImage(String roomNumber, String imageUrl) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            String jpql = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.images WHERE r.roomNumber = :rn";
            TypedQuery<Room> query = em.createQuery(jpql, Room.class);
            query.setParameter("rn", roomNumber);
            List<Room> list = query.getResultList();

            if (!list.isEmpty()) {
                Room room = list.get(0);
                if (room.getImages() != null) {
                    for (RoomImage img : room.getImages()) {
                        if (img.getImageUrl().equals(imageUrl)) {
                            img.setPrimary(true);
                        } else {
                            img.setPrimary(false);
                        }
                        em.merge(img);
                    }
                }
            }
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }
}
