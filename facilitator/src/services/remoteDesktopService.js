const axios = require('axios');
const logger = require('../utils/logger');
const config = require('../config');

class RemoteDesktopService {
    constructor() {
        this.baseUrl = `http://${config.remoteDesktop.host}:${config.remoteDesktop.port}`;
        this.maxRetries = 10;
        this.initialRetryDelay = 1000; // 1 second
    }

    /**
     * Wait for a specified time
     * @param {number} ms - Milliseconds to wait
     * @returns {Promise<void>}
     */
    async sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }

    /**
     * Restart the VNC session with retry logic
     * @returns {Promise<void>}
     */
    async restartVncSession() {
        let lastError;
        
        for (let attempt = 1; attempt <= this.maxRetries; attempt++) {
            try {
                logger.info(`Attempting to restart VNC session (attempt ${attempt}/${this.maxRetries})`);
                
                await axios.get(`${this.baseUrl}/restart-vnc-session`, {
                    timeout: 5000 // 5 second timeout
                });
                
                logger.info('VNC session restart initiated successfully');
                return;
            } catch (error) {
                lastError = error;
                const errorMsg = error.response?.data?.error || error.message;
                
                logger.warn(`Failed to restart VNC session (attempt ${attempt}/${this.maxRetries})`, {
                    error: errorMsg,
                    willRetry: attempt < this.maxRetries
                });
                
                if (attempt < this.maxRetries) {
                    // Exponential backoff: 1s, 2s, 4s, 8s, etc.
                    const delay = this.initialRetryDelay * Math.pow(2, attempt - 1);
                    logger.info(`Waiting ${delay}ms before retry...`);
                    await this.sleep(delay);
                }
            }
        }
        
        // All retries exhausted
        logger.error('Failed to restart VNC session after all retries', {
            error: lastError.response?.data?.error || lastError.message,
            attempts: this.maxRetries
        });
        throw new Error('Failed to restart VNC session');
    }

    /**
     * Copy content to remote desktop clipboard
     * @param {string} content - Content to copy to clipboard
     * @returns {Promise<void>}
     */
    async copyToClipboard(content) {
        try {
            if (!content) {
                throw new Error('Clipboard content is required');
            }

            await axios.post(`${this.baseUrl}/clipboard-paste`, {
                content: content
            }, {
                headers: {
                    'Content-Type': 'application/json'
                },
                timeout: 5000
            });
        } catch (error) {
            logger.error('Failed to copy content to clipboard', {
                error: error.response?.data?.error || error.message
            });
            throw new Error('Failed to copy content to clipboard');
        }
    }
}

// Export singleton instance
module.exports = new RemoteDesktopService();