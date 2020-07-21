package com.itboyst.facedemo.dto;

import com.arcsoft.face.Rect;
import lombok.Data;


/**
 * @author teswell
 */
@Data
public class FaceDetectResDTO {
    private Rect rect;
    private int orient;
    private int faceId = -1;
    private int age = -1;
    private int gender = -1;
    private int liveness = -1;
}
