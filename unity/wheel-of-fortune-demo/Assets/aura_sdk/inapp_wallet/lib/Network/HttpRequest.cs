using UnityEngine;
using UnityEngine.Networking;
using Newtonsoft.Json;
using System.Threading.Tasks;
using System.Net.Http;
namespace AuraSDK{
    public class HttpRequest {
        public static async Task<HttpResponse> Post(string url, object obj){
            string jsonData = JsonConvert.SerializeObject(obj);
            UnityWebRequest unityWebRequest = new UnityWebRequest();
            unityWebRequest.url = url;
            unityWebRequest.method = UnityWebRequest.kHttpVerbPOST;
            unityWebRequest.uploadHandler = new UploadHandlerRaw(jsonData.ToByteArrayUTF8());
            unityWebRequest.downloadHandler = new DownloadHandlerBuffer();
            unityWebRequest.SetRequestHeader("Accept", "application/json");
            unityWebRequest.SetRequestHeader("Content-Type", "application/json");
            await unityWebRequest.SendWebRequest();
            return new HttpResponse(){
                StatusCode = unityWebRequest.responseCode,
                Content = unityWebRequest.downloadHandler.text
            };
        }
        public static async Task<T> Post<T>(string url, object obj){
            var rawResponse = await Post(url, obj);
            if (rawResponse.StatusCode == 200)
                return JsonConvert.DeserializeObject<T>(rawResponse.Content);
            else return default(T);
        }
        public static async Task<HttpResponse> Get(string url){
            UnityWebRequest unityWebRequest = UnityWebRequest.Get(url);
            unityWebRequest.downloadHandler = new DownloadHandlerBuffer();
            unityWebRequest.SetRequestHeader("Accept", "application/json");
            unityWebRequest.SetRequestHeader("Content-Type", "application/json");
            await unityWebRequest.SendWebRequest();
            return new HttpResponse(){
                StatusCode = unityWebRequest.responseCode,
                Content = unityWebRequest.downloadHandler.text
            };
        }
        public static async Task<T> Get<T>(string url){
            var rawResponse = await Get(url);
            if (rawResponse.StatusCode == 200)
                return JsonConvert.DeserializeObject<T>(rawResponse.Content);
            else return default(T);
        }
    }
}