using UnityEngine ;
using UnityEngine.UI ;
using DG.Tweening ;
using UnityEngine.Events ;
using System.Collections.Generic ;
using TUtils;
using System.Collections;
namespace EasyUI.PickerWheelUI {

   public class PickerWheel : MonoBehaviour {

      [Header ("References :")]
      [SerializeField] private GameObject linePrefab ;
      [SerializeField] private Transform linesParent ;

      [Space]
      [SerializeField] private Transform PickerWheelTransform ;
      [SerializeField] private Transform wheelCircle ;
      [SerializeField] private GameObject wheelPiecePrefab ;
      [SerializeField] private Transform wheelPiecesParent ;

      [Space]
      [Header ("Sounds :")]
      [SerializeField] private AudioSource audioSource ;
      [SerializeField] private AudioClip tickAudioClip ;
      [SerializeField] [Range (0f, 1f)] private float volume = .5f ;
      [SerializeField] [Range (-3f, 3f)] private float pitch = 1f ;

      [Space]
      [Header ("Picker wheel settings :")]
      public int spinDuration = 8 ;
      [SerializeField] [Range (.2f, 2f)] private float wheelSize = 1f ;

      [Space]
      [Header ("Picker wheel pieces :")]
      public WheelPiece[] wheelPieces ;

      // Events
      private UnityAction onSpinStartEvent ;
      private UnityAction<WheelPiece> onSpinEndEvent ;


      private bool _isSpinning = false ;

      public bool IsSpinning { get { return _isSpinning ; } }


      private Vector2 pieceMinSize = new Vector2 (81f, 146f) ;
      private Vector2 pieceMaxSize = new Vector2 (144f, 213f) ;
      private int piecesMin = 2 ;
      private int piecesMax = 12 ;

      private float pieceAngle ;
      private float halfPieceAngle ;
      private float halfPieceAngleWithPaddings ;


      private double accumulatedWeight ;
      private System.Random rand = new System.Random () ;

      private List<int> nonZeroChancesIndices = new List<int> () ;
      void Start(){
         ReInit();
      }
      public void ReInit () {
         for (int i = 0; i < wheelPiecesParent.childCount; ++i)
            Destroy(wheelPiecesParent.GetChild(i).gameObject);
         for (int i = 0; i < linesParent.childCount; ++i)
            Destroy(linesParent.GetChild(i).gameObject);

         pieceAngle = 360 / wheelPieces.Length ;
         halfPieceAngle = pieceAngle / 2f ;
         halfPieceAngleWithPaddings = halfPieceAngle - (halfPieceAngle / 4f) ;

         Generate () ;  

         CalculateWeightsAndIndices () ;
         if (nonZeroChancesIndices.Count == 0)
            Debug.LogError ("You can't set all pieces chance to zero") ;
         SetupAudio () ;
      }

      private void SetupAudio () {
         audioSource.clip = tickAudioClip ;
         audioSource.volume = volume ;
         audioSource.pitch = pitch ;
      }

      private void Generate () {
         //wheelPiecePrefab = InstantiatePiece () ;

         RectTransform rt = wheelPiecePrefab.transform.GetChild (0).GetComponent <RectTransform> () ;
         float pieceWidth = Mathf.Lerp (pieceMinSize.x, pieceMaxSize.x, 1f - Mathf.InverseLerp (piecesMin, piecesMax, wheelPieces.Length)) ;
         float pieceHeight = Mathf.Lerp (pieceMinSize.y, pieceMaxSize.y, 1f - Mathf.InverseLerp (piecesMin, piecesMax, wheelPieces.Length)) ;
         rt.SetSizeWithCurrentAnchors (RectTransform.Axis.Horizontal, pieceWidth) ;
         rt.SetSizeWithCurrentAnchors (RectTransform.Axis.Vertical, pieceHeight) ;

         for (int i = 0; i < wheelPieces.Length; i++)
            DrawPiece (i) ;

         //Destroy (wheelPiecePrefab) ;
      }

      private void DrawPiece (int index) {
         WheelPiece piece = wheelPieces [ index ] ;
         Transform pieceTrns = InstantiatePiece ().transform.GetChild (0) ;

         pieceTrns.GetChild (0).GetComponent <Image> ().sprite = piece.Icon ;
         pieceTrns.GetChild (1).GetComponent <Text> ().text = piece.Label ;
         pieceTrns.GetChild (2).GetComponent <Text> ().text = piece.Amount.ToString () ;

         //Line
         Transform lineTrns = Instantiate (linePrefab, linesParent.position, Quaternion.identity, linesParent).transform ;
         lineTrns.RotateAround (wheelPiecesParent.position, Vector3.back, (pieceAngle * index) + halfPieceAngle) ;

         pieceTrns.RotateAround (wheelPiecesParent.position, Vector3.back, pieceAngle * index) ;
      }

      private GameObject InstantiatePiece () {
         return Instantiate (wheelPiecePrefab, wheelPiecesParent.position, Quaternion.identity, wheelPiecesParent) ;
      }

      Coroutine spinningCoroutine = null;
      int landedPiece = -1;
      float Angle0360(float z){
         z -= (float) (int) (z / 360f) * 360f;
         if (z < 0) z += 360f;
         return z;
      }
      IEnumerator Spin(){
         float speed = 0f;
         const float MAX_SPEED = 360f, ACCELERATION = 180f;
         float deceleration = -1f; //degrees per second, degrees per second square
         while (true){
            if (landedPiece < 0){ //no landed piece
               speed = Mathf.Min(MAX_SPEED, speed + ACCELERATION * Time.deltaTime);
            } else {
               if (deceleration < 0) {
                  float destZ = 360f / wheelPieces.Length * landedPiece + Random.Range(1f, -1f) * 120f / (float) wheelPieces.Length;
                  float z = wheelCircle.transform.eulerAngles.z;
                  float angle = Angle0360(destZ - z) + 1080f; //> 0
                  Tebug.Verbose("Travel", angle, "from", z, "to", destZ);
                  deceleration = speed * speed / 2f / angle;
               }
               speed = Mathf.Max(0f, speed - deceleration * Time.deltaTime);
               if (speed <= 0) {
                  onSpinEndEvent.Invoke(wheelPieces[landedPiece]);
                  _isSpinning = false;
                  yield break;
               }
            }
            wheelCircle.transform.rotation = Quaternion.Euler(wheelCircle.transform.eulerAngles + Vector3.forward * speed * Time.deltaTime);
            yield return null;
         }
      }
      public void StartSpinning () {
         if (!_isSpinning) {
            _isSpinning = true ;
            landedPiece = -1;
            if (onSpinStartEvent != null)
               onSpinStartEvent.Invoke () ;

            spinningCoroutine = Watcher.StartCoroutine(Spin(), false);
         }
      }
      public void LandOn(int pieceIndex){
         Tebug.Log("Determined to land on", pieceIndex);
         landedPiece = pieceIndex;
      }
      public void StopSpinning(){
         if (_isSpinning){
            _isSpinning = false;
            Watcher.StopCoroutine(spinningCoroutine);
         }
      }

      public void OnSpinStart (UnityAction action) {
         onSpinStartEvent = action ;
      }

      public void OnSpinEnd (UnityAction<WheelPiece> action) {
         onSpinEndEvent = action ;
      }


      private int GetRandomPieceIndex () {
         double r = rand.NextDouble () * accumulatedWeight ;
         TUtils.Tebug.Log("r =", r);
         for (int i = 0; i < wheelPieces.Length; i++)
            if (wheelPieces [ i ]._weight >= r)
               return i ;

         return 0 ;
      }

      private void CalculateWeightsAndIndices () {
         accumulatedWeight = 0;
         for (int i = 0; i < wheelPieces.Length; i++) {
            WheelPiece piece = wheelPieces [ i ] ;

            //add weights:
            accumulatedWeight += piece.Chance ;
            piece._weight = accumulatedWeight ;

            //add index :
            piece.Index = i ;

            //save non zero chance indices:
            if (piece.Chance > 0)
               nonZeroChancesIndices.Add (i) ;
         }
      }




      private void OnValidate () {
         if (PickerWheelTransform != null)
            PickerWheelTransform.localScale = new Vector3 (wheelSize, wheelSize, 1f) ;

         if (wheelPieces.Length > piecesMax || wheelPieces.Length < piecesMin)
            Debug.LogError ("[ PickerWheelwheel ]  pieces length must be between " + piecesMin + " and " + piecesMax) ;
      }
   }
}