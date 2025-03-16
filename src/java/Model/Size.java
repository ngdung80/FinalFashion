
package Model;

/**
 *
 * @author ICBAdmin
 */
public class Size {
    private int sizeID;
    private String sizeName;

    public Size() {
    }

    public Size(int sizeID, String sizeName) {
        this.sizeID = sizeID;
        this.sizeName = sizeName;
    }

    public int getSizeID() {
        return sizeID;
    }

    public void setSizeID(int sizeID) {
        this.sizeID = sizeID;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }
    
    
}
