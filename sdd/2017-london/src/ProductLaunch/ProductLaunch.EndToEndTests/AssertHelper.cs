using NUnit.Framework;
using System;
using System.Threading;

namespace ProductLaunch.EndToEndTests
{
    public static class AssertHelper
    {
        public static void RetryAssert(int retryInterval, int retryCount, string failureMessage, Func<bool> assertion)
        {
            var assert = assertion();
            var count = 1;
            while (assert == false && count < retryCount)
            {
                Thread.Sleep(retryInterval);
                assert = assertion();
                count++;
            }
            Assert.IsTrue(assert, failureMessage);
        }
    }
}
