﻿using System.Linq;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Flurl.Util;

namespace Flurl.Http
{
	/// <summary>
	/// Fluent extension methods for downloading a file.
	/// </summary>
	public static class DownloadExtensions
	{
		/// <summary>
		/// Asynchronously downloads a file at the specified URL.
		/// </summary>
		/// <param name="request">The flurl request.</param>
		/// <param name="localFolderPath">Path of local folder where file is to be downloaded.</param>
		/// <param name="localFileName">Name of local file. If not specified, the source filename (from Content-Dispostion header, or last segment of the URL) is used.</param>
		/// <param name="bufferSize">Buffer size in bytes. Default is 4096.</param>
		/// <param name="cancellationToken">The token to monitor for cancellation requests.</param>
		/// <returns>A Task whose result is the local path of the downloaded file.</returns>
		public static async Task<string> DownloadFileAsync(this IFlurlRequest request, string localFolderPath, string localFileName = null, int bufferSize = 4096, CancellationToken cancellationToken = default(CancellationToken)) {
			using (var resp = await request.SendAsync(HttpMethod.Get, cancellationToken: cancellationToken, completionOption: HttpCompletionOption.ResponseHeadersRead).ConfigureAwait(false)) {
				localFileName =
					localFileName ??
					GetFileNameFromHeaders(resp) ??
					GetFileNameFromPath(request);

				// http://codereview.stackexchange.com/a/18679
				using (var httpStream = await resp.Content.ReadAsStreamAsync().ConfigureAwait(false))
				using (var fileStream = await FileUtil.OpenWriteAsync(localFolderPath, localFileName, bufferSize).ConfigureAwait(false)) {
					await httpStream.CopyToAsync(fileStream, bufferSize, cancellationToken).ConfigureAwait(false);
				}
			}

			return FileUtil.CombinePath(localFolderPath, localFileName);
		}

		private static string GetFileNameFromHeaders(HttpResponseMessage resp) {
			var header = resp.Content?.Headers.ContentDisposition;
			if (header == null) return null;
			// prefer filename* per https://tools.ietf.org/html/rfc6266#section-4.3
			var val = (header.FileNameStar ?? header.FileName)?.StripQuotes();
			if (val == null) return null;
			return FileUtil.MakeValidName(val);
		}

		private static string GetFileNameFromPath(IFlurlRequest req) {
			return FileUtil.MakeValidName(Url.Decode(req.Url.Path.Split('/').Last(), false));
		}

		/// <summary>
		/// Asynchronously downloads a file at the specified URL.
		/// </summary>
		/// <param name="url">The Url.</param>
		/// <param name="localFolderPath">Path of local folder where file is to be downloaded.</param>
		/// <param name="localFileName">Name of local file. If not specified, the source filename (last segment of the URL) is used.</param>
		/// <param name="bufferSize">Buffer size in bytes. Default is 4096.</param>
		/// <param name="cancellationToken">The token to monitor for cancellation requests.</param>
		/// <returns>A Task whose result is the local path of the downloaded file.</returns>
		public static Task<string> DownloadFileAsync(this string url, string localFolderPath, string localFileName = null, int bufferSize = 4096, CancellationToken cancellationToken = default(CancellationToken)) {
			return new FlurlRequest(url).DownloadFileAsync(localFolderPath, localFileName, bufferSize, cancellationToken);
		}

		/// <summary>
		/// Asynchronously downloads a file at the specified URL.
		/// </summary>
		/// <param name="url">The Url.</param>
		/// <param name="localFolderPath">Path of local folder where file is to be downloaded.</param>
		/// <param name="localFileName">Name of local file. If not specified, the source filename (last segment of the URL) is used.</param>
		/// <param name="bufferSize">Buffer size in bytes. Default is 4096.</param>
		/// <param name="cancellationToken">The token to monitor for cancellation requests.</param>
		/// <returns>A Task whose result is the local path of the downloaded file.</returns>
		public static Task<string> DownloadFileAsync(this Url url, string localFolderPath, string localFileName = null, int bufferSize = 4096, CancellationToken cancellationToken = default(CancellationToken)) {
			return new FlurlRequest(url).DownloadFileAsync(localFolderPath, localFileName, bufferSize, cancellationToken);
		}
	}
}